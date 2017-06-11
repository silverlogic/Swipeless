//
//  SWBaseViewController.swift
//  Swipeless
//
//  Created by Silver Logic on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import UIKit
import YYWebImage

class SWBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let image : UIImage = UIImage(named: "NavLogo_Title")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .pink
        let userImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        if let imageString = UserManager.shared.currentUser?.avatar {
            userImageView.yy_setImage(with: URL(string: imageString), placeholder: UIImage(), options: .setImageWithFadeAnimation, completion: nil)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: userImageView.image, style: .plain, target: self, action: #selector(segueToMatches))
        }
    }
}


extension SWBaseViewController {
    @objc fileprivate func segueToMatches() {
        print("Segue")
    }
}
