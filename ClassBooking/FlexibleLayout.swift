//
//  FlexibleLayout.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import UIKit

class FlexibleLayout: UICollectionViewLayout {
    
    let cellHeight: Double = 30.0
    let horizontalSpacing: Double = 5.0
    let verticalSpaing: Double = 5.0
    let headerSpacing = 50.0
            
    var cellAttrsDictionary = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    var contentSize = CGSize.zero
    var portrait_Ypos : Double = 0.0
    
    override var collectionViewContentSize : CGSize {
        return self.contentSize
    }
    
    override func prepare() {
        guard let collectionView = self.collectionView else { return }
        
        let sectionCount = collectionView.numberOfSections
        let cellWidth = Double((collectionView.frame.width - 6 * CGFloat(horizontalSpacing)) / 7)
        var maxY: Double = 0
        
        for section in 0 ..< sectionCount {
            let itemCount = collectionView.numberOfItems(inSection: section)
            
            for item in 0 ..< itemCount {
                let xPos = (Double(section) * cellWidth) + (Double(section) * horizontalSpacing)
                var yPos : Double = 0.0
                
                yPos = item == 0 ? headerSpacing : portrait_Ypos + cellHeight + verticalSpaing
                portrait_Ypos = yPos
                maxY = maxY < portrait_Ypos ? portrait_Ypos : maxY
                
                let cellIndex = IndexPath(item: item, section: section)
                let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
                cellAttributes.frame = CGRect(x: xPos, y: yPos, width: cellWidth, height: cellHeight)
                
                // Determine zIndex based on cell type.
                if section == 0 && item == 0 {
                    cellAttributes.zIndex = 4
                } else if section == 0 {
                    cellAttributes.zIndex = 3
                } else if item == 0 {
                    cellAttributes.zIndex = 2
                } else {
                    cellAttributes.zIndex = 1
                }
                cellAttrsDictionary[cellIndex] = cellAttributes
            }
        }
        
        let contentWidth = Double(sectionCount) * cellWidth + (Double(sectionCount - 1) * horizontalSpacing)
        let contentHeight = maxY + cellHeight
        self.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesInRect = [UICollectionViewLayoutAttributes]()
        
        for cellAttributes in cellAttrsDictionary.values {
            if rect.intersects(cellAttributes.frame) {
                attributesInRect.append(cellAttributes)
                             
                if let supplementaryAttributes = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: cellAttributes.indexPath),
                   cellAttributes.indexPath.item == 0 {
                    attributesInRect.append(supplementaryAttributes)
                }
                
            }
        }
        
        return attributesInRect
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttrsDictionary[indexPath]!
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == UICollectionView.elementKindSectionHeader,
           let itemAttributes = layoutAttributesForItem(at: indexPath) {
            
            let atts = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: indexPath)
            atts.frame = CGRect(x: itemAttributes.frame.origin.x,
                                y: itemAttributes.frame.origin.y - CGFloat(headerSpacing),
                                width: itemAttributes.frame.width,
                                height: CGFloat(headerSpacing))
            
            return atts
        }
        return nil
    }
    
}
