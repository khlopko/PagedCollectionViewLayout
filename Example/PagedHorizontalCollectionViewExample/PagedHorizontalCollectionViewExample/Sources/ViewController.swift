//
//  ViewController.swift
//  

import UIKit

final class ViewController : UIViewController {

    @IBOutlet weak var collectionView: UICollectionView?
    
    fileprivate let reuseID = "Cell"
    private var flowLayout: UICollectionViewFlowLayout? {
        return collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayout?.minimumLineSpacing = 10
        flowLayout?.scrollDirection = .horizontal
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseID)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let bounds = collectionView?.bounds, let layout = flowLayout {
            layout.itemSize = CGSize(width: bounds.width - 40, height: bounds.height)
        }
    }
    
    override func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator
    ) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

extension ViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath)
        let fi = CGFloat(indexPath.item)
        cell.backgroundColor = UIColor(red: fi / 25.5, green: fi / 12.25, blue: fi / 51, alpha: 1)
        return cell
    }
}
