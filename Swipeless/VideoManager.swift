//
//  VideoManager.swift
//  Swipeless
//
//  Created by Silver Logic on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import AVFoundation
import Foundation
import SVProgressHUD
import Photos

final class VideoManager: NSObject {
    
    // MARK: - Shared Instance
    static let shared = VideoManager()
    
    
    // MARK: - Attributes
    fileprivate var session: AVCaptureSession?
    fileprivate var responseVideoData = NSData()
    fileprivate var responseImageData = NSData()
    fileprivate let _videoCaptureDuration: TimeInterval = 5.0
    fileprivate var timer = Timer()
    
    
    // MARK: - Initializers
    private override init() {}
}

extension VideoManager: AVCaptureFileOutputRecordingDelegate {
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        print(fileURL)
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        print(outputFileURL)
        guard let fileMainURL = outputFileURL else { return }
        do {
            let asset = AVURLAsset(url: fileMainURL, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            let image = UIImage(cgImage: cgImage)
            responseImageData = NSData(contentsOf: fileMainURL)!
            let savedPath = saveImageToDocumentDirectory(image)
            print(savedPath)
        } catch let error as NSError {
            print(error)
            return
        }
        let videoFilePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("mergeVideo\(arc4random()%1000)d").appendingPathExtension("mp4").absoluteString
        if FileManager.default.fileExists(atPath: videoFilePath) {
            do {
                try FileManager.default.removeItem(atPath: videoFilePath)
            } catch {}
        }
        let tempFileMainURL = URL(string: videoFilePath)!
        let sourceAsset = AVURLAsset(url: fileMainURL, options: nil)
        let assetExport: AVAssetExportSession = AVAssetExportSession(asset: sourceAsset, presetName: AVAssetExportPresetMediumQuality)!
        assetExport.outputFileType = AVFileTypeQuickTimeMovie
        assetExport.outputURL = tempFileMainURL
        assetExport.exportAsynchronously { Void in
            switch assetExport.status {
            case .completed:
                DispatchQueue.main.async {
                    do {
                        self.responseVideoData = try NSData(contentsOf: tempFileMainURL, options: NSData.ReadingOptions())
//                        KairosManager.shared.postToKairos(path: tempFileMainURL)
                        print("MB - \(self.responseVideoData.length) byte")
                    } catch let error as NSError {
                        print(error)
                    }
                }
            case .failed: break
//                print("Failed: \(String(describing: assetExport.error))")
            case .cancelled: break
//                print("Cancelled: \(String(describing: assetExport.error))")
            default:
                print("Complete")
                SVProgressHUD.dismiss()
            }
        }
    }
    
    func saveImageToDocumentDirectory(_ chosenImage: UIImage) -> String {
        let directoryPath =  NSHomeDirectory().appending("/Documents/")
        if !FileManager.default.fileExists(atPath: directoryPath) {
            do {
                try FileManager.default.createDirectory(at: NSURL.fileURL(withPath: directoryPath), withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }
        let filename = "image.jpg"
        let filepath = directoryPath.appending(filename)
        let url = NSURL.fileURL(withPath: filepath)
        KairosManager.shared.postToKairos(path: url)
        do {
            try UIImageJPEGRepresentation(chosenImage, 1.0)?.write(to: url, options: .atomic)
            return String.init("/Documents/\(filename)")
            
        } catch {
            print(error)
//            print("file cant not be save at path \(filepath), with error : \(error)");
            return filepath
        }
    }
}


// MARK: - Public Instance Methods
extension VideoManager {
    public func createSession(_ previewView: UIView?) {
        guard let preview = previewView else { return }
        var input: AVCaptureDeviceInput?
        let movieFileOutput = AVCaptureMovieFileOutput()
        var prevLayer: AVCaptureVideoPreviewLayer?
        prevLayer?.frame.size = preview.frame.size
        session = AVCaptureSession()
        let error: NSError? = nil
        guard let device = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .front) else {
            return
        }
        do { input = try AVCaptureDeviceInput(device: device) } catch { return }
        if error == nil {
            session?.addInput(input)
        } else {
//            print("Camera input error: \(String(describing: error))")
        }
        prevLayer = AVCaptureVideoPreviewLayer(session: session)
        prevLayer?.frame.size = preview.frame.size
        prevLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        prevLayer?.connection.videoOrientation = .portrait
        prevLayer?.isHidden = false
        previewView?.layer.addSublayer(prevLayer!)
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileMainURL = URL(string: ("\(documentsURL.appendingPathComponent("swipeless"))" + ".mov"))
        
        let maxDuration: CMTime = CMTimeMake(600, 10)
        movieFileOutput.maxRecordedDuration = maxDuration
        movieFileOutput.minFreeDiskSpaceLimit = 1024 * 1024
        if (self.session?.canAddOutput(movieFileOutput))! {
            self.session?.addOutput(movieFileOutput)
        }
        session?.startRunning()
        movieFileOutput.startRecording(toOutputFileURL: fileMainURL, recordingDelegate: self)
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: _videoCaptureDuration, target: self, selector: #selector(stopVideoRecording), userInfo: nil, repeats: false)
    }
}


// MARK: - Private Instance Methods
extension VideoManager {
    @objc fileprivate func stopVideoRecording() {
        session?.stopRunning()
    }
}
