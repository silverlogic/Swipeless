//
//  NewMatchCollectionViewCell.swift
//  Swipeless
//
//  Created by Michael Sevy on 6/11/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import UIKit

class NewMatchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageForMatch: UIImageView!

    func configure(image: UIImage) {
        imageForMatch.image = image
    }
}
