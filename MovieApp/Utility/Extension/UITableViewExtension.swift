//
//  UITableViewExtension.swift
//  MovieApp
//
//  Created by Winter on 3/15/24.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCell(_ cell: UITableViewCell.Type) {
        let cellId = String(describing: cell.self)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    func dequeueCell<T: UITableViewCell>(_ cell: T.Type,for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: String(describing: T.self),for: indexPath) as? T else {
            fatalError("\(String(describing: T.self)) could not be found!")
        }
        return cell
    }
}
