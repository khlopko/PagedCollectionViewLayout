//
//  PagedFlowLayout.swift
//  

import UIKit

open class PagedFlowLayout : UICollectionViewFlowLayout {
    
    open override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else {
            return .zero
        }
        var size = super.collectionViewContentSize
        let count = CGFloat(collectionView.numberOfItems(inSection: 0))
        size.width = collectionView.bounds.width * count
        return size
    }
    private var pageWidth: CGFloat {
        return collectionView?.bounds.width ?? 1
    }
    private var movementWidth: CGFloat {
        return itemSize.width + minimumLineSpacing
    }
    
    open override func layoutAttributesForElements(
        in rect: CGRect
    ) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView, collectionView.numberOfItems(inSection: 0) > 0 else {
            return super.layoutAttributesForElements(in: rect)
        }
        let lowerBound = item(for: rect.midX - pageWidth * 1.5)
        let upperBound = item(for: rect.midX + pageWidth * 1.5)
        return (lowerBound...upperBound)
            .flatMap { item -> UICollectionViewLayoutAttributes? in
                guard
                    item < collectionView.numberOfItems(inSection: 0),
                    let attribute = layoutAttributesForItem(at: IndexPath(item: item, section: 0)) else {
                        return nil
                }
                let di = collectionView.contentOffset.x / pageWidth - CGFloat(attribute.indexPath.item)
                let x = collectionView.contentOffset.x - offset(for: di)
                attribute.frame.origin.x = x
                return attribute
        }
    }
    
    open override func layoutAttributesForItem(
        at indexPath: IndexPath
    ) -> UICollectionViewLayoutAttributes? {
        guard let copy = super.layoutAttributesForItem(at: indexPath)?.copy() else {
            return nil
        }
        let attributes = copy as! UICollectionViewLayoutAttributes
        attributes.frame.origin = CGPoint(x: offset(for: CGFloat(indexPath.item)), y: 0)
        return attributes
    }
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return newBounds != collectionView?.bounds
    }
    
    // MARK: - Private
    
    private func offset(for item: CGFloat) -> CGFloat {
        guard let collectionWidth = collectionView?.bounds.width else {
            return 0
        }
        let s = (collectionWidth - itemSize.width) * 0.5
        return item * movementWidth - s
    }
    
    private func item(for offset: CGFloat) -> Int {
        let e = Int(round(offset / pageWidth))
        let total = collectionView?.numberOfItems(inSection: 0) ?? 0
        return max(0, min(e, total))
    }
}
