//
//  LoginManager.swift
//  Swipeless
//
//  Created by Michael Sevy on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import Foundation
import Alamofire
import FBSDKLoginKit

final class LoginManager {

    static let shared = LoginManager()

    private init() {}
}

extension LoginManager {

  // @TODO send to API user's facebook info


}

struct FacebookUserInfo {

    // MARK: - Public Instance Attributes
    let email: String
    let facebookAccessToken: String
    let firstName: String
    let lastName: String
    let avatar: String?


    // MARK: - Getters & Setters
    var parameters: Alamofire.Parameters {
        var params: Parameters = [
            "email": email,
            "facebookAccessToken": facebookAccessToken,
            "firstName": firstName,
            "lastName": lastName
        ]
        if let avatarURLForUser = avatar {
            params["avatarUrl"] = avatarURLForUser
        }
        return params
    }

    init(email: String, facebookAccessToken: String, firstName: String, lastName: String, avatar: String?) {
        self.email = email
        self.facebookAccessToken = facebookAccessToken
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
    }
}
