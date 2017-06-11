//
//  KairosManager.swift
//  Swipeless
//
//  Created by Michael Sevy on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import MobileCoreServices

/**
    A singleton responsible for kairos operations.
 */
final class KairosManager {

    // MARK: - Shared Instance
    static let shared = KairosManager()

    
    // MARK: - Attributes
    let mediaURL = "https://api.kairos.com/v2/media"
    let analyticsURL = "https://api.kairos.com/v2/analytics"
    var parsedItems = [[String:Any]]()
    

    // MARK: - Initializers

    /**
        Initializes a shared instance of `KairosManager`.
     */
    private init() {}
}

extension KairosManager {

    func postToKairos(path: URL) {
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(path, withName: "source")
        },
        to: mediaURL,
        method: .post,
        headers: ["app_id": "5766848c", "app_key": "7b825a5c093b4f9dcad42e8d31476497"],
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                print("Uploading...")
                upload.responseObject { (response: DataResponse<Upload>) in
                    guard let uploadID = response.result.value?.uploadID else { return }
                    self.checkUploadStatus(uploadID: uploadID)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    )}
    
    @objc func checkUploadStatus(uploadID: String?) {
        print("Checking upload status")
        var url = ""
        var idString = ""
        if let uploadIdentifier = uploadID {
            url = "\(mediaURL)/\(uploadIdentifier)"
            idString = uploadIdentifier
        }
        Alamofire.request(url, headers: ["app_id": "5766848c", "app_key": "7b825a5c093b4f9dcad42e8d31476497"]).responseObject { [weak self] (response: DataResponse<Upload>) in
            guard let strongSelf = self else { return }
            if let message = response.result.value?.status {
                if message == "Complete" {
                    strongSelf.getUserEmotions(uploadID: idString)
                } else {
                    print("Status: \(message)...Rechecking Upload Status")
                    let when = DispatchTime.now() + 4
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        strongSelf.checkUploadStatus(uploadID: uploadID)
                    }
                }
            }
        }
    }
    
    func getUserEmotions(uploadID: String) {
        print("Getting Emotional")




        let url = URL(string: "https://api.kairos.com/v2/analytics/\(uploadID)")!
        var request = URLRequest(url: url)
        request.addValue("5766848c", forHTTPHeaderField: "app_id")
        request.addValue("7b825a5c093b4f9dcad42e8d31476497", forHTTPHeaderField: "app_key")

        Alamofire.request(request).responseObject { (response: DataResponse<User>) in
            if let user = response.result.value {
            }
        }
        // Kairos example from http://docs.kairos.apiary.io/#reference/emotion-analysis/v2analyticsid/get
        //let url = URL(string: "https://api.kairos.com/v2/analytics/{id}")!
        //var request = URLRequest(url: url)
        //request.addValue("4985f625", forHTTPHeaderField: "app_id")
        //request.addValue("aa9e5d2ec3b00306b2d9588c3a25d68e", forHTTPHeaderField: "app_key")

//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let response = response, let data = data {
//
//                print(String(data: data, encoding: .utf8) ?? "dafsdf")
//
//                do {
//                    let json: [String : Any] = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]?!!
//                    print("**\(json["id"]!)")
//                    print("***\(json["impressions"]!)")
//                    print("JSON***\(String(describing: json))")
//                } catch let error {
//                    print(error)
//                }
//            }
//        }
//
//        task.resume()
    }

}
