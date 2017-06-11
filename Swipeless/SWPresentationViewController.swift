//
//  SWPresentationViewController.swift
//  Swipeless
//
//  Created by Silver Logic on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import UIKit

final class SWPresentationViewController: SWBaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet fileprivate weak var previewView: UIView!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - IBActions
    @IBAction func startTapped(_ sender: UIButton) {
    }
    
}
