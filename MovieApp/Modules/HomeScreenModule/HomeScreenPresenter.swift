//
//  MoviesListScreenPresenter.swift
//  MoviesViwer
//
//  Created by Winter on 3/13/24.
//

import Foundation


class HomeScreenPresenter {
    
    private weak var view: HomeScreenPresenterToViewProtocol?
    private let interactor: HomeScreenPresenterToInteractorProtocol
    private let router: HomeScreenPresenterToRouterProtocol
    
    init(_ view: HomeScreenPresenterToViewProtocol,
         _ interactor: HomeScreenPresenterToInteractorProtocol,
         _ router: HomeScreenPresenterToRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - View -> Presneter
extension HomeScreenPresenter: HomeScreenViewToPresenterProtocol {
    
    func viewDidLoad() {
        view?.collectionViewHeaders = interactor.getHeaders()
        if ConnectionService.isConnectedToNetwork() {
            view?.showLoading(true)
            interactor.fetchMovies()
            return
        }
        interactor.fetchLocalMovies()
        view?.showToatMessage(Message.NO_CONNECTION_MESSAGE)
    }
    
    func onRefreshData() {
        interactor.fetchMovies()
    }
    
    func onSearchButtonClicked(_ query: String) {
        view?.showLoading(true)
        interactor.searchMovie(query)
    }
    
    func onCollectionViewHeaderButtonClicked(_ title: String) {
        router.navigateToMovieListScreen(title)
    }
    
    func onMovieItemClicked(_ movieId: Int) {
        router.navigateToMovieDetailScreen(movieId)
    }
}


// MARK: - Interactor -> Presneter
extension HomeScreenPresenter: HomeScreenInteractorToPresenterProtocol {
    
    func onNowPlayingSuccess(_ movies: [MovieData]) {
        view?.nowPlayingMovieData = movies
    }
    
    func onPopularSuccess(_ movies: [MovieData]) {
        view?.popularMovieData = movies
    }
    
    func onTopRatedSuccess(_ movies: [MovieData]) {
        view?.topRatedMovieData = movies
    }
    
    func onUpcomingSuccess(_ movies: [MovieData]) {
        view?.upcomingMovieData = movies
    }
    
    func finishedFetchMovies() {
        view?.showLoading(false)
    }
    
    func onSearchMovieSuccess(_ movies: [MovieData]) {
        view?.searchMovieData = movies
        view?.showLoading(false)
    }
    
    func onFailure(_ message: String) {
        view?.showLoading(false)
        view?.showToatMessage(message)
    }
}
