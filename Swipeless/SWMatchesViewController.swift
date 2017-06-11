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
    @IBOutlet var collectioView: UICollectionView!

    // MARK: - Instance Variable
    var matches: [UIImage]?

    override func viewDidLoad() {
        super.viewDidLoad()
        matches = [UIImage]()

    }

}


// MARK: - CollectionView DataSource
extension SWMatchesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
        //return matches?.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewMatchCollectionViewCell = collectionView.cellForItem(at: indexPath) as! NewMatchCollectionViewCell
        return cell
    }
}


// MARK: - CollectionView Delegate
extension SWMatchesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? NewMatchCollectionViewCell else { return }
        cell.configure(image: #imageLiteral(resourceName: "F2"))
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
