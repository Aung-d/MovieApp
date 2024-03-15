//
//  MovieListScreenPresenter.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import Foundation


class MovieListScreenPresenter {
    
    private weak var view: MovieListScreenPresenterToViewProtocol?
    private let interactor: MovieListScreenPresenterToInteractorProtocol
    private let router: MovieListScreenPresenterToRouterProtocol
    
    init(_ view: MovieListScreenPresenterToViewProtocol? = nil,_ interactor: MovieListScreenPresenterToInteractorProtocol,_ router: MovieListScreenPresenterToRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - View -> Presneter
extension MovieListScreenPresenter: MovieListScreenViewToPresenterProtocol {
    
    func viewDidLoad() {
        view?.showLoading(true)
        interactor.fetchMovies(false)
    }
    
    func getTitle() -> String {
        interactor.title
    }
    
    func onBackButtonClicked() {
        router.navigateBack()
    }
    
    func onLoadMoreMovies() {
        view?.showPagingLoadingView(true)
        interactor.fetchMovies(true)
    }
    
    func onMovieItemClicked(_ movieId: Int) {
        router.navigateToMovieDetailScreen(movieId)
    }
    
}


// MARK: - Interactor -> Presneter
extension MovieListScreenPresenter: MovieListScreenInteractorToPresenterProtocol {
    
    func onSuccess(_ movies: [MovieData], _ isPaging: Bool) {
        if isPaging {
            view?.movieList.append(contentsOf: movies)
            view?.showPagingLoadingView(false)
            return
        }
        view?.showLoading(false)
        view?.movieList = movies
    }
    
    func onFailure(_ message: String, _ isPaging: Bool) {
        view?.showToatMessage(message)
        if isPaging {
            view?.showPagingLoadingView(false)
            return
        }
        view?.showLoading(false)
    }
    
    func noMorePagingData() {
        
    }
    
}
