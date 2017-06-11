//
//  SWBaselineViewController.swift
//  Swipeless
//
//  Created by Silver Logic on 6/11/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import UIKit
import DottedProgressBar

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
        imageView.image = images[counter - 1]
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        VideoManager.shared.createSession(previewView)
        updateImage()
        self.animateProgressBar()
    }
}


// MARK: - Private Instance Methods
extension SWBaselineViewController {
    fileprivate func updateImage() {
        let when = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: when) {
            if self.counter < 5 {
                self.animateProgressBar()
                VideoManager.shared.createSession(self.previewView)
                self.imageView.image = self.images[self.counter]
                self.counter = self.counter + 1
                if self.counter == 6 {
                    // Segue
                }
                self.updateImage()
            }
        }
    }
    
    fileprivate func animateProgressBar() {
            let progressBar = DottedProgressBar(frame: CGRect(x: imageView.frame.minX, y: imageView.frame.maxY + 20, width: imageView.frame.size.width, height: 5), numberOfDots: 4, initialProgress: 0)
            progressBar.progressAppearance = DottedProgressBar.DottedProgressAppearance(
                dotRadius: 8.0,
                dotsColor: .white,
                dotsProgressColor: .pink,
                backColor: .clear
            )
            view.addSubview(progressBar)
            progressBar.setProgress(1, animated: true)
            progressBar.progressChangeAnimationDuration = 0.2
            progressBar.setProgress(2)
            progressBar.setProgress(3)
            progressBar.setProgress(4)
            let when = DispatchTime.now() + 5
            DispatchQueue.main.asyncAfter(deadline: when) {
                progressBar.removeFromSuperview()
        }
    }
}
