//
//  UICollectionViewExtension.swift
//  MovieApp
//
//  Created by Winter on 3/13/24.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func registerCell(_ cell: UICollectionViewCell.Type) {
        let cellId = String(describing: cell.self)
        register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    func registerSupplementaryCell(_ cell: UICollectionViewCell.Type) {
        let cellId = String(describing: cell.self)
        register(UINib(nibName: cellId, bundle: nil),forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellId)
    }
    
    func dequeueCell<T: UICollectionViewCell>(_ cell: T.Type,for indexPath: IndexPath) -> T {
        return dequeueReusableCell(
            withReuseIdentifier: String(describing: T.self),for: indexPath) as! T
    }
    
    func dequeueSupplementaryCell<T: UICollectionViewCell>(
        _ kind: String, _ cell: T.Type,for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(
            ofKind: kind, withReuseIdentifier:
                String(describing: T.self), for: indexPath) as! T
    }
}
