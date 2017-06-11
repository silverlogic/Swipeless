//
//  UserManager.swift
//  Swipeless
//
//  Created by Silver Logic on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import Foundation
import Alamofire

class UserManager: NSObject {
    
    // MARK: - Shared Instance
    static let shared = UserManager()
    
    
    // MARK: - Attributes
    var currentUser: FacebookUserInfo?
    
    
    // MARK: - Init
    private override init() {}
}


// MARK: - Public Instance Methods
extension UserManager {
    public func setUser(_ user: FacebookUserInfo) {
        currentUser = user
    }

    func postSeeking(email: String?, seeking: String?, success: @escaping (_ true: Bool) -> Void, failure: @escaping (_ error: Error) -> Void) {
        let url = "https://swipeless.herokuapp.com/api/v0/seek"
        let params = ["email" : email, "seeking" : seeking]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
        .responseJSON { response in
            if let userResponse = response.result.value {
                print("**response: \(userResponse)")
                success(true)
            }
            if response.result.isFailure {
                print("**error:\(response.result.error as Any)")
                failure(response.result.error!)
                //throw error
            }
        }
    }
}

//    func getPotentialMatches() {
//        let url = URL(string: "https://swipeless.herokuapp.com/api/v0/browse")!
//        //var request = URLRequest(url: url)
//        let params = ["email" : "tbevan@gmail.com"]
//
//        Alamofire.request(url, method: .post, parameters: params).responseJSON { (response) in
//
//        let dict = response.result.value
//            for (key, value) in dict {
//                if key == "name" {
//
//                }
//            }
//        }

//        for values in impressions.emotions! {
//            for (key, value) in values as! [String: Any] {
//                if key == "average_emotion" {
//                    print("****** Real Data: \(value as! [String: Int])")
//                    self.postSentiments(value as! [String : Int])
//                }
//            }
//        }
        //request.addValue("email" : "tbevan@gmail.com")
        //request.addValue("tbevan@gmail.com", forHTTPHeaderField: "email")
        //request.addValue("7b825a5c093b4f9dcad42e8d31476497", forHTTPHeaderField: "app_key")
//        Alamofire.request(request).responseString { (response) in

//            if let impressions = response.result.value {
//                if (impressions.emotions?.isEmpty)! {
//                    let sentiments = self.generateFakeData()
//                    self.postSentiments(sentiments)
//                    print("****** Fake Data because empty emotions: \(sentiments)")
//                    return
//                }
//                for values in impressions.emotions! {
//                    for (key, value) in values as! [String: Any] {
//                        if key == "average_emotion" {
//                            print("****** Real Data: \(value as! [String: Int])")
//                            self.postSentiments(value as! [String : Int])
//                        }
//                    }
//                }
//            } else {
//                let sentiments = self.generateFakeData()
//                self.postSentiments(sentiments)
//                print("****** Fake Data after failed response: \(sentiments)")
//            }

   // }

