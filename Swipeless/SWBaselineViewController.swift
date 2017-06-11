//
//  SWBaselineViewController.swift
//  Swipeless
//
//  Created by Silver Logic on 6/11/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import UIKit

final class SWBaselineViewController: SWBaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var progressBar: UIProgressView!
    @IBOutlet fileprivate weak var previewView: UIView!
    
    
    // MARK: - Attributes
    fileprivate var images = [UIImage]()
    var timer = Timer()
    var counter = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        images.append(UIImage(named: "abstract1")!)
        images.append(UIImage(named: "abstract2")!)
        images.append(UIImage(named: "abstract3")!)
        images.append(UIImage(named: "abstract4")!)
        images.append(UIImage(named: "abstract5")!)
        imageView.image = images[0]
        VideoManager.shared.createSession(previewView)
        updateImage()
    }
}


// MARK: - Private Instance Methods
extension SWBaselineViewController {
    fileprivate func updateImage() {
        let when = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: when) {
            if self.counter < 5 {
                VideoManager.shared.createSession(self.previewView)
                self.imageView.image = self.images[self.counter]
                self.counter = self.counter + 1
                self.updateImage()
            }
        }
    }
}
