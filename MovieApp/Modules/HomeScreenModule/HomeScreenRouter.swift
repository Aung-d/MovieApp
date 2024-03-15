//
//  MovieListScreenRouter.swift
//  MoviesViwer
//
//  Created by Winter on 3/13/24.
//

import Foundation
import UIKit

class HomeScreenRouter: BaseRouter<HomeScreenViewController> {
    
    init() {
        super.init(storyboardName: StoryboardName.HOME_SCREEN, type: HomeScreenViewController.self)
        let interactor = HomeScreenInteractor()
        let presenter = HomeScreenPresenter(viewController, interactor, self)
        interactor.presenter = presenter
        viewController.presenter = presenter
        
    }
}

// MARK: - Presenter -> Router
extension HomeScreenRouter: HomeScreenPresenterToRouterProtocol {
    
    func navigateToMovieListScreen(_ title: String) {
        self.pushViewTo(MovieListScreenRouter(title))
    }
    
    func navigateToMovieDetailScreen(_ movieId: Int) {
        self.pushViewTo(MovieDetailScreenRouter(movieId))
    }
}
