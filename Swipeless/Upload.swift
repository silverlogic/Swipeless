//
//  Upload.swift
//  Swipeless
//
//  Created by Silver Logic on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import UIKit
import ObjectMapper

class Upload: Mappable {
    
    // MARK: - Public Instance Methods
    var uploadID: String!
    var status: String!

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        uploadID <- map["id"]
        status <- map["status_message"]
    }
}
