//
//  BaseNavigationController.swift
//  MoviesViwer
//
//  Created by Winter on 3/13/24.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    init<T: UIViewController>(_ router: BaseRouter<T>) {
        super.init(rootViewController: router.viewController)
        router.viewController.navigationController?.navigationBar.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
