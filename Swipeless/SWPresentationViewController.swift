//
//  SWPresentationViewController.swift
//  Swipeless
//
//  Created by Silver Logic on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import UIKit

final class SWPresentationViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet fileprivate weak var previewView: UIView!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        VideoManager.shared.createSession(previewView)
    }
}
