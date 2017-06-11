//
//  FacebookManager.swift
//  Swipeless
//
//  Created by Michael Sevy on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import FBSDKShareKit

/**
    A singleton responsible for facebook operations.
 */
final class FacebookManager {

    // MARK: - Shared Instance
    static let shared = FacebookManager()


    // MARK: - Initializers

    /**
     Initializes a shared instance of `FacebookManager`.
     */
    private init() {}
}


// MARK: - Private Instance Methods
fileprivate extension FacebookManager {

    fileprivate func fetchFacebookData(facebookToken: String,_ success: @escaping (FacebookUserInfo) -> Void, failure: @escaping (_ error: Error) -> Void) {
        let params = ["fields": "email, id, picture, first_name, last_name, gender"]
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)
        graphRequest!.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil) {
                failure(error!)
            } else {
                typealias JSONDictionary = [String: Any]
                let results = result as? [String:Any]
                if let email = results?["email"] as? String,
                   let id = results?["id"] as? String,
                   let firstName = results?["first_name"] as? String,
                   let lastName = results?["last_name"] as? String,
                   let gender = results?["gender"] as? String,
                   let picture = results?["picture"] as? [String:Any]?,
                   let pictureFolder = picture?["data"] as? [String: Any]?,
                   let avatarUrl = pictureFolder?["url"] as? String? {
                    let user = FacebookUserInfo(userId: id, email: email, facebook: facebookToken, firstName: firstName, lastName: lastName, avatar: avatarUrl!, gender: gender)
                    success(user)
                    UserManager.shared.setUser(user)
                }
            }
        })
    }
}


// MARK: - Public Instance Methods
extension FacebookManager {

    /**
     Activates the Facebook App Events SDK.
     */
    func activate() {
        FBSDKAppEvents.activateApp()
    }

    /**
     Logs the user out and clears token.
     */
    func logout() {
        FBSDKLoginManager().logOut()
    }

    /**
     Initializes the facebook application delegate.
     */
    func initializeDelegate(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    /**
     Initializes the facebook url delegate.
     */
    func initializeURLDelegate(application: UIApplication, url: URL, options:[UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL!, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }

    /**
     Initialize Source Application delegate.
     */
    func initializeSourceApplicationDelegate(application: UIApplication, url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func loginToFacebookForPermissions(viewController: UIViewController, _ success: @escaping (_ facebookData: FacebookUserInfo) -> Void, failure: @escaping (_ error: Error) -> Void) {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["public_profile", "email"], from:viewController) { [weak self] (result, error) -> Void in
            if (result?.grantedPermissions != nil) {
                if (result!.grantedPermissions.contains("email")) {
                    guard let strongSelf = self else { return }
                    strongSelf.fetchFacebookData(facebookToken: FBSDKAccessToken.current().tokenString, { (loginData: FacebookUserInfo) in
                        success(loginData)
                    }, failure: { (error: Error) in
                        failure(error)
                    })
                }
            }
        }
    }
}
