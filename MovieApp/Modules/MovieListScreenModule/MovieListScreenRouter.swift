//
//  MovieListScreenRouter.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import Foundation


class MovieListScreenRouter: BaseRouter<MovieListScreenViewController> {
    
    init(_ title: String) {
        super.init(storyboardName: StoryboardName.MOVIE_LIST_SCREEN, type: MovieListScreenViewController.self)
        let interactor = MovieListScreenInteractor(title)
        let presenter = MovieListScreenPresenter(viewController, interactor, self)
        interactor.presenter = presenter
        viewController.presenter = presenter
        
    }
    
}

// MARK: - Presenter -> Router
extension MovieListScreenRouter: MovieListScreenPresenterToRouterProtocol {
    
    func navigateBack() {
        self.popViewController()
    }
    
    func navigateToMovieDetailScreen(_ movieId: Int) {
        self.pushViewTo(MovieDetailScreenRouter(movieId))
    }
}

