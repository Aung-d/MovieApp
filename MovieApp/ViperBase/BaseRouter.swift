//
//  BaseRouter.swift
//  MoviesViwer
//
//  Created by Winter on 3/13/24.
//

import Foundation
import UIKit

class BaseRouter<T: UIViewController> {
    let viewController: T
    
    init(storyboardName: String, type: T.Type) {
        self.viewController = UIStoryboard.init(name: storyboardName, bundle: nil)
            .instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
    
    func pushViewTo<D: UIViewController>(_ router: BaseRouter<D>) {
        viewController.navigationController?.pushViewController(router.viewController, animated: true)
    }
    
    func popViewController() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



