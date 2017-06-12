//
//  SWMatchesViewController.swift
//  Swipeless
//
//  Created by Michael Sevy on 6/11/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import UIKit

class SWMatchesViewController: SWBaseViewController {

    // MARK: Outlets
    @IBOutlet var collectionView: UICollectionView!

    // MARK: - Instance Variable
    var matches = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        matches = ["https://images.unsplash.com/photo-1458696352784-ffe1f47c2edc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=500&h=500&fit=crop&s=dfd08b6a9f4330782b9faf34c483d840","https://images.unsplash.com/photo-1468218457742-ee484fe2fe4c?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=500&h=500&fit=crop&s=5a2fb5958972abf38e0e6aedc14dcb69", "https://images.unsplash.com/photo-1437011165434-0b8d687711aa?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=500&h=500&fit=crop&s=a770bcbf6f1a8d70421d282d14beb545", "https://images.unsplash.com/photo-1456327102063-fb5054efe647?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=500&h=500&fit=crop&s=6a406c2d49a97a261ed1326029ce27c7"]
    }

}


// MARK: - CollectionView DataSource
extension SWMatchesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matches.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewMatchCollectionViewCell", for: indexPath) as? NewMatchCollectionViewCell else {
            return UICollectionViewCell()
        }
        let urlString = matches[indexPath.row]
        if let cellURL = URL(string: urlString) {
            cell.configure(url: cellURL)
        }
        return cell
    }
}


// MARK: - CollectionView Delegate FlowLayout
extension SWMatchesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // @TODO adjust width and height in proportion to cell height and width
        return CGSize(width: view.frame.width / 2.5 as CGFloat, height: view.frame.width / 2.5 as CGFloat)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 8, 0, 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
}
