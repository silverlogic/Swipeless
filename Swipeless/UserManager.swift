//
//  UserManager.swift
//  Swipeless
//
//  Created by Silver Logic on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import Foundation

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
}
