//
//  UICollectionView+Register.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import UIKit

extension UICollectionView {
    
    //MARK: - Register - Cell
    func registerNib<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let nib = UINib(nibName: cellType.className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func registerNib<T: UICollectionViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { registerNib(cellType: $0, bundle: bundle) }
    }
    
    func register<T: UICollectionViewCell>(cellTypes: T.Type) {
        register(cellTypes, forCellWithReuseIdentifier: cellTypes.className)
    }
    
    func register<T: UICollectionViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellTypes: $0) }
    }
    
    //MARK: - Register - Header / Footer
    func registerNib<T: UICollectionReusableView>(reusableViewType: T.Type,
                                               ofKind kind: String = UICollectionView.elementKindSectionHeader,
                                               bundle: Bundle? = nil) {
        let nib = UINib(nibName: reusableViewType.className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    func registerNib<T: UICollectionReusableView>(reusableViewTypes: [T.Type],
                                               ofKind kind: String = UICollectionView.elementKindSectionHeader,
                                               bundle: Bundle? = nil) {
        reusableViewTypes.forEach { registerNib(reusableViewType: $0, ofKind: kind, bundle: bundle) }
    }

    func register<T: UICollectionReusableView>(reusableViewType: T.Type,
                                               ofKind kind: String = UICollectionView.elementKindSectionHeader) {
        register(reusableViewType, forSupplementaryViewOfKind: kind, withReuseIdentifier: reusableViewType.className)
    }
    
    func register<T: UICollectionReusableView>(reusableViewTypes: [T.Type],
                                               ofKind kind: String = UICollectionView.elementKindSectionHeader) {
        reusableViewTypes.forEach { register(reusableViewType: $0, ofKind: kind) }
    }
    
    //MARK: - Dequeue
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                      for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type,
                                                          for indexPath: IndexPath,
                                                          ofKind kind: String = UICollectionView.elementKindSectionHeader) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className, for: indexPath) as! T
    }
    
}
