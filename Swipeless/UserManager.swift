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
