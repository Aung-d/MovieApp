//
//  MovieDetailScreenRouter.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import Foundation

class MovieDetailScreenRouter: BaseRouter<MovieDetailScreenViewController> {
    
    init(_ movieId: Int) {
        super.init(storyboardName: StoryboardName.MOVIE_DETAIL_SCREEN, type: MovieDetailScreenViewController.self)
        let interactor = MovieDetailScreenInteractor(movieId)
        let presenter = MovieDetailScreenPresenter(viewController, interactor, self)
        interactor.presenter = presenter
        viewController.presenter = presenter
    }
    
}

// MARK: - Presenter -> Router
extension MovieDetailScreenRouter: MovieDetailScreenPresenterToRouterProtocol {
    
    func navigateBack() {
        self.popViewController()
    }
    
    func navigateToPlayerScreen(_ posterPath: String,_ videoInfos: [VideoInfo]) {
        self.pushViewTo(TrailerScreenRouter(posterPath, videoInfos))
    }
}
