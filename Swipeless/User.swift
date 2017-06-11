//
//  User.swift
//  Swipeless
//
//  Created by Silver Logic on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireObjectMapper

final class User: Mappable {
    
    // MARK: - Public Instance Methods
    var email: String!
    var token: String!
    var firstName: String!
    var lastName: String!
    var avatarURL: String!
    var gender: String!
    var userId: String!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        userId <- map["id"]
        email <- map["email"]
        token <- map["token"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        avatarURL <- map["avatar"]
        gender <- map["gender"]
    }
}
