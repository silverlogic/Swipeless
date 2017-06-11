//
//  SWSeekingViewController.swift
//  Swipeless
//
//  Created by Silver Logic on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import UIKit
import FaveButton


final class SWSeekingViewController: SWBaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet fileprivate weak var maleButton: UIButton!
    @IBOutlet fileprivate weak var femaleButton: UIButton!
    @IBOutlet fileprivate weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.maleButton.setImage(self.selectRandomMaleImage(), for: .normal)
            self.femaleButton.setImage(self.selectRandomFemaleImage(), for: .normal)
        }
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
