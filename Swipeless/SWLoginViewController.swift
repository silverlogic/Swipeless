//
//  SWLoginViewController.swift
//  Swipeless
//
//  Created by Michael Sevy on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SWLoginViewController: UIViewController {

    @IBOutlet weak var swipeIessIconImage: UIImageView!
    @IBOutlet weak var facebookLoginButton: UIButton!


    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let _ = FBSDKAccessToken.current() {
//            self.performSegue(withIdentifier: "LoginToPresentationSegue", sender: self)
//        }
    }


    @IBAction func loginTapped(_ sender: UIButton) {
        FacebookManager.shared.loginToFacebookForPermissions(viewController: self, { (facebookUserInfo: FacebookUserInfo) in
            LoginManager.shared.loginUser(facebookUserInfo: facebookUserInfo, success: { (userInfo) in
                print("*****\(userInfo)")
            }, failure: { (error) in
                print("**error: \(error)")
            })
            self.performSegue(withIdentifier: "LoginToPresentationSegue", sender: self)
        }) { (error) in
            print(error)
            //handle error
        }
    }

}
