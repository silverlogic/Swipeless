//
//  SWReactionViewController.swift
//  Swipeless
//
//  Created by Michael Sevy on 6/11/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import UIKit

class SWReactionViewController: SWBaseViewController {

    // MARK: - IBOutlets
    @IBOutlet fileprivate weak var potentialMatchImageView: UIImageView!
    @IBOutlet fileprivate weak var potentialMatchLabel: UILabel!
    @IBOutlet fileprivate weak var previewView: UIView!
    @IBOutlet fileprivate weak var sentimentEmojiLabel: UILabel!
    @IBOutlet fileprivate weak var heatFactorImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!

    // MARK: - Instance Variable
    var table: [[String : String]] = [
    ["name" : "Gretna", "lastName" : "Waterson", "email" : "gwaterson0@theglobeandmail.com", "bio" : "Centralized tangible help-desk", "image" : "https://images.unsplash.com/photo-1437011165434-0b8d687711aa?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=500&h=500&fit=crop&s=a770bcbf6f1a8d70421d282d14beb545"],
    ["name" : "Wernher", "lastName" : "Yepiskov", "email" : "wyepiskov4@hubpages.com", "bio" : "Reactive 6th generation parallelism", "image" : "https://images.unsplash.com/photo-1458696352784-ffe1f47c2edc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=500&h=500&fit=crop&s=dfd08b6a9f4330782b9faf34c483d840"],
    ["name" : "Charisse", "lastName" : "Alven", "email" : "calven5@myspace.com", "bio" : "Integrated encompassing archive", "image" : "https://images.unsplash.com/photo-1456327102063-fb5054efe647?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=500&h=500&fit=crop&s=6a406c2d49a97a261ed1326029ce27c7"],
    ["name" : "Peta", "lastName" : "Arenson", "email" : "parenson6@census.gov", "bio" : "Object-based multi-state moderator", "image" : "https://images.unsplash.com/photo-1464716441148-e84e7fd56872?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=500&h=500&fit=crop&s=8300b6af51da4a9f1ceb44ebc3713ce5"],
    ["name" : "Allie", "lastName" : "Lawson", "email" : "alawson7@redcross.org", "bio" : "Quality-focused empowering methodology", "image" : "https://images.unsplash.com/photo-1468218457742-ee484fe2fe4c?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=500&h=500&fit=crop&s=5a2fb5958972abf38e0e6aedc14dcb69"],
    ["name" : "Willdon", "lastName" : "Blumer", "email" : "wblumera@abc.net.au", "bio" : "Automated 6th generation system engine", "image" : "https://images.unsplash.com/photo-1437011165434-0b8d687711aa?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=500&h=500&fit=crop&s=a770bcbf6f1a8d70421d282d14beb545"],
    ["name" : "Waite", "lastName" : "Broggio", "email" : "wbroggiob@google.com.hk", "bio" : "User-friendly background Graphical User Interface", "image" : "https://images.unsplash.com/photo-1459941081785-f4e7e433e8e4?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=500&h=500&fit=crop&s=82fbc03f1bfe91077b836a02e3cc6fd5"],
    ["name" : "Candida", "lastName" : "Chaimson", "email" : "cchaimsong@nps.gov", "bio" : "Focused tertiary archive", "image" : "https://images.unsplash.com/photo-1488637715726-23b600e11339?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=500&h=500&fit=crop&s=dd5174988d6edaed1242dd00dc1c9b54"],
    ["name" : "Mirabella", "lastName" : "Dermot", "email" : "mdermot8@yandex.ru", "bio" : "Function-based needs-based hardware", "image" : "https://images.unsplash.com/photo-1476937619554-0f08b179a10c?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=500&h=500&fit=crop&s=65e95b6a4cf61237409633bb4e773377"],
    ["name" : "Joey", "lastName" : "O'Driscoll", "email" : "jodriscollh@illinois.edu",  "bio" : "Exclusive fresh-thinking application", "image" : "https://images.unsplash.com/photo-1490292444162-c4debb4598bd?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=500&h=500&fit=crop&s=21d2d18e226a7d10d95fd59456542b80"],
    ]
    var angers: [String]    = ["😤", "😡", "😠", "😑"]
    var disgusts: [String]  = ["😖", "🤢", "😷", "💩"]
    var fears: [String]     = ["😢", "🙁", "😨", "😳"]
    var joys: [String]      = ["😀", "😃", "😋", "😊"]
    var sadness: [String]   = ["😐", "😕", "☹️", "😖"]
    var surprise: [String]  = ["😮", "😯", "😵", "😧"]
    var hearts: [UIImage]   = [#imageLiteral(resourceName: "Heart_Red"), #imageLiteral(resourceName: "Heart_Orange"), #imageLiteral(resourceName: "Heart_Yellow"), #imageLiteral(resourceName: "Heart_OrangyRed")]
    var potentialMatches: [String]?
    var showCounter = 0
    var imageCount = 0
    var emojiCount = 0
    var heartCount = 0
    var imageURLs = [String]()
    var biosArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        for dict in table {
            if let image = dict["image"] {
                potentialMatches?.append(image)
            }
        }
        showPotentialMatchImage()

    }
}



extension SWReactionViewController {

    func showPotentialMatchImage() {
        //images start at zero then increment every 5 seconds
        for image in table {
            let url = image["image"]
            imageURLs.append(url!)
        }
        updatePhoto()
        updateBios()
        for bios in table {
            potentialMatchLabel.text = bios["bio"]
            biosArray.append(bios["bio"]!)
        }
        sentimentEmojiLabel.text = angers[emojiCount]
        heatFactorImageView.image = hearts[self.heartCount]
        for names in table {
            nameLabel.text = names["name"]
        }
        potentialMatchImageView.yy_setImage(with: URL(string: imageURLs[0]), placeholder: UIImage(), options: .setImageWithFadeAnimation, completion: nil)
        let when = DispatchTime.now() + 4
        DispatchQueue.main.asyncAfter(deadline: when) {
            if self.showCounter > 4 {
                self.imageCount += 1
                //self.showCounter = 0
                self.heartCount += 1
                self.showPotentialMatchImage()
            }
            if self.emojiCount == 4 {
                self.emojiCount = 0
            } else {
                self.emojiCount += 1
                self.showPotentialMatchImage()
            }
            if self.heartCount == 4 {
                self.heartCount = 0
            } else {
                self.showPotentialMatchImage()
                self.heartCount += 1
            }
        }
    }

    func updateBios() {
        let when = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: when) { 
            if self.imageCount < 8 {
                self.potentialMatchLabel.text = self.biosArray[self.imageCount]
                self.updateBios()
            }
        }
    }

    func updatePhoto() {
        let when = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: when) {
            if self.imageCount < 8 {
                self.potentialMatchImageView.yy_setImage(with: URL(string: self.imageURLs[self.imageCount]), placeholder: UIImage(), options: .setImageWithFadeAnimation, completion: nil)
                self.imageCount = self.imageCount + 1
                self.updatePhoto()
            }
        }
    }

}
