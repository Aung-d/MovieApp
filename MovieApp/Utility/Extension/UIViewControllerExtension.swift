//
//  UIViewControllerExtension.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayLoading(_ isShow: Bool) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let existingView = windowScene?.windows[0].viewWithTag(1200)
        if isShow {
            if existingView != nil {
                return
            }
            let loadingView = self.configureLoadingView()
            loadingView.tag = 1200
            windowScene?.windows[0].addSubview(loadingView)
        } else {
            existingView?.removeFromSuperview()
        }
    }
    
    
    private func configureLoadingView() -> UIView {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let containerView = UIView(frame: windowScene?.windows.first?.frame ?? self.view.frame)
        containerView.backgroundColor = .lightGray.withAlphaComponent(0.5)
            
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        activityIndicatorView.color = .white
        activityIndicatorView.center = CGPoint(x: containerView.frame.size.width / 2, y: containerView.frame.size.height / 2)
        
        containerView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        return containerView
    }
    
    func movieCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(110),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        group.interItemSpacing = .flexible(16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        
        return UICollectionViewCompositionalLayout(section: section)
    }
   
}
