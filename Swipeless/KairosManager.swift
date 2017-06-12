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
    var counter = 0

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
                    self.counter = 0
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
                    print("[\(strongSelf.counter)]Status: \(message) ... Rechecking Upload Status")
                    let when = DispatchTime.now() + 5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        if strongSelf.counter < 5 {
                            strongSelf.checkUploadStatus(uploadID: uploadID)
                        } else {
                            let sentiments = strongSelf.generateFakeData()
                            strongSelf.postSentiments(sentiments)
                            print("****** Data: \(sentiments)")
                        }
                        strongSelf.counter = strongSelf.counter + 1
                    }
                }
            }
        }
    }
    
    func getUserEmotions(uploadID: String) {
        print("Let's get emotional")
        let url = URL(string: "https://api.kairos.com/v2/analytics/\(uploadID)")!
        var request = URLRequest(url: url)
        request.addValue("5766848c", forHTTPHeaderField: "app_id")
        request.addValue("7b825a5c093b4f9dcad42e8d31476497", forHTTPHeaderField: "app_key")
        Alamofire.request(request).responseObject { (response: DataResponse<User>) in
            print("OK, Getting Emotional")
            if let impressions = response.result.value {
                if (impressions.emotions?.isEmpty)! {
                    let sentiments = self.generateFakeData()
                    self.postSentiments(sentiments)
                    print("****** Data: \(sentiments)")
                    return
                }
                for values in impressions.emotions! {
                    for (key, value) in values as! [String: Any] {
                        if key == "average_emotion" {
                            print("****** Real Data: \(value as! [String: Int])")
                            self.postSentiments(value as! [String : Int])
                        }
                    }
                }
            } else {
                let sentiments = self.generateFakeData()
                self.postSentiments(sentiments)
                print("****** Data: \(sentiments)")
            }
        }
    }
    
    fileprivate func postSentiments(_ sentiment: [String: Int]) {
        let url = URL(string: "https://swipeless.herokuapp.com/api/v0/rate/")!
        let params = ["email": "btredgeto@adobe.com", "imageId": Int(arc4random_uniform(5)), "anger": sentiment["anger"]!, "disgust": sentiment["disgust"]!, "fear": sentiment["fear"]!, "joy": sentiment["joy"]!, "sadness": sentiment["sadness"]!, "surprise": sentiment["surprise"]!] as [String : Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString { response in
                print(response)
        }
    }
    
    private func randomSentimentValue() -> Int {
        return Int(arc4random_uniform(100))
    }
    
    private func generateFakeData() -> [String: Int] {
        let emotions = ["anger", "disgust", "fear", "sadness", "surprise", "joy"]
        var sentiments = ["anger": 0, "disgust": 0, "fear": 0, "sadness": 0, "surprise": 0, "joy": 0]
        for _ in 0...1 {
            let value = self.randomSentimentValue()
            let index = Int(arc4random_uniform(5))
            sentiments[emotions[index]] = value
        }
        return sentiments
    }
}
