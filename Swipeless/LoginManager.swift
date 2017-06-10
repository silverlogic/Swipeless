//
//  LoginManager.swift
//  Swipeless
//
//  Created by Michael Sevy on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

final class LoginManager {

    static let shared = LoginManager()

    private init() {}
}

extension LoginManager {
    func loginUser(facebookUserInfo: FacebookUserInfo, success: @escaping (_ userInfo: FacebookUserInfo) -> Void, failure: @escaping (_ error: Error) -> Void) {
        let url = "http://iqmvimhmbk.localtunnel.me/api/v0/register"
        let params: [String : Any] = ["email" : facebookUserInfo.email, "facebook" : facebookUserInfo.facebook, "firstName" : facebookUserInfo.firstName, "lastName" : facebookUserInfo.lastName, "gender" : facebookUserInfo.gender, "avatar" : facebookUserInfo.avatar]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
            if let userResponse = response.result.value {
                print("**response: \(userResponse)")
            }
            success(facebookUserInfo)
            if response.result.isFailure {
                print(response.result.error as Any)
            }
        }
    }
}

struct FacebookUserInfo {

    // MARK: - Public Instance Attributes
    let email: String
    let facebook: String
    let firstName: String
    let lastName: String
    let gender: String
    let avatar: String
    let userID: String


    // MARK: - Getters & Setters
    var parameters: Alamofire.Parameters {
        let params: Parameters = [
            "id": userID,
            "email": email,
            "facebookAccessToken": facebook,
            "firstName": firstName,
            "lastName": lastName,
            "gender" : gender,
            "avatar" : avatar
        ]
        return params
    }

    init(userId: String, email: String, facebook: String, firstName: String, lastName: String, avatar: String, gender: String) {
        self.userID = userId
        self.email = email
        self.facebook = facebook
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.gender = gender
    }
}
