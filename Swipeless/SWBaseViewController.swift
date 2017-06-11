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
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "facebook-profilepic"), for: .normal)
        button.addTarget(self, action: #selector(segueToMatches), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
}


extension SWBaseViewController {
    @objc fileprivate func segueToMatches() {
        print("Segue")
    }
}
