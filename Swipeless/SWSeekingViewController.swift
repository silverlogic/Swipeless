//
//  SWSeekingViewController.swift
//  Swipeless
//
//  Created by Silver Logic on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import UIKit
import Foundation

final class SWSeekingViewController: SWBaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet fileprivate weak var maleButton: UIButton!
    @IBOutlet fileprivate weak var femaleButton: UIButton!
    @IBOutlet fileprivate weak var nextButton: UIButton!


    // MARK: - Public Instance Methods
    var seeking: String?


    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        seeking = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.maleButton.setImage(self.selectRandomMaleImage(), for: .normal)
            self.femaleButton.setImage(self.selectRandomFemaleImage(), for: .normal)
        }
    }

    @IBAction func maleButtonTapped(_ sender: UIButton) {
        seeking = "male"
        maleButton.backgroundColor = .clear
        maleButton.layer.cornerRadius = femaleButton.layer.frame.size.width / 2
        maleButton.layer.masksToBounds = true
        maleButton.layer.borderWidth = 1
        maleButton.layer.borderColor = UIColor.black.cgColor
//        if seeking == "male" {
//            seeking = ""
//            maleButton.layer.masksToBounds = false
//            maleButton.layer.borderWidth = 0
//        } else {
//            seeking = "male"
//            maleButton.backgroundColor = .clear
//            maleButton.layer.cornerRadius = femaleButton.layer.frame.size.width / 2
//            maleButton.layer.masksToBounds = true
//            maleButton.layer.borderWidth = 1
//            maleButton.layer.borderColor = UIColor.black.cgColor
//        }
    }


    @IBAction func femaleButtonTapped(_ sender: Any) {
        seeking = "female"
        femaleButton.backgroundColor = .clear
        femaleButton.layer.cornerRadius = femaleButton.layer.frame.size.width / 2
        femaleButton.layer.masksToBounds = true
        femaleButton.layer.borderWidth = 1
        femaleButton.layer.borderColor = UIColor.black.cgColor

//        if seeking == "female" {
//            seeking = ""
//            femaleButton.layer.masksToBounds = false
//            femaleButton.layer.borderWidth = 0
//
//        } else {
//            seeking = "female"
//            femaleButton.backgroundColor = .clear
//            femaleButton.layer.cornerRadius = femaleButton.layer.frame.size.width / 2
//            femaleButton.layer.masksToBounds = true
//            femaleButton.layer.borderWidth = 1
//            femaleButton.layer.borderColor = UIColor.black.cgColor
//        }
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        //if let user = UserManager.shared.currentUser {
        UserManager.shared.postSeeking(email: "michaelsevy@gmail.com", seeking: seeking, success: { [weak self] (success) in
            guard let strongSelf = self else { return }
            strongSelf.performSegue(withIdentifier: "SegueToBaseLineDescription", sender: self)
            }, failure: { (error) in
                print(error)
        })
    }
}


// MARK: - Private Instance Methods
extension SWSeekingViewController {
    fileprivate func selectRandomMaleImage() -> UIImage {
        let maleImages: [UIImage] = [UIImage(named: "M1")!, UIImage(named: "M2")!, UIImage(named: "M3")!, UIImage(named: "M4")!, UIImage(named: "M5")!, UIImage(named: "M6")!, UIImage(named: "M7")!, UIImage(named: "M8")!, UIImage(named: "M9")!, UIImage(named: "M10")!]
        return maleImages[randomNumber()]
    }
    
    fileprivate func selectRandomFemaleImage() -> UIImage {
        let femaleImages: [UIImage] = [UIImage(named: "F1")!, UIImage(named: "F2")!, UIImage(named: "F3")!, UIImage(named: "F4")!, UIImage(named: "F5")!, UIImage(named: "F6")!, UIImage(named: "F7")!, UIImage(named: "F8")!, UIImage(named: "F9")!, UIImage(named: "F10")!]
        return femaleImages[randomNumber()]
    }
    
    private func randomNumber() -> Int {
        return Int(arc4random_uniform(10))
    }
}
