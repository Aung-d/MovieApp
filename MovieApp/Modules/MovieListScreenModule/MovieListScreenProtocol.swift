//
//  MovieListScreenProtocol.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import Foundation

// MARK: - Presenter -> View
protocol MovieListScreenPresenterToViewProtocol: AnyObject {
    var movieList: [MovieData] { get set }
    func showLoading(_ isLoading: Bool)
    func showPagingLoadingView(_ isLoading: Bool)
    func showToatMessage(_ message: String)
}

// MARK: - View -> Presenter
protocol MovieListScreenViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
    func getTitle() -> String
    func onBackButtonClicked()
    func onLoadMoreMovies()
    func onMovieItemClicked(_ movieId: Int)
}

// MARK: - Interactor -> Presenter
protocol MovieListScreenInteractorToPresenterProtocol: AnyObject {
    func onSuccess(_ movies: [MovieData], _ isPaging: Bool)
    func onFailure(_ message: String,  _ isPaging: Bool)
    func noMorePagingData()
}

// MARK: - Presenter -> Interactor
protocol MovieListScreenPresenterToInteractorProtocol: AnyObject {
    var title: String { get }
    func fetchMovies( _ isPaging: Bool)
}

// MARK: - Presenter -> Router or WireFrame
protocol MovieListScreenPresenterToRouterProtocol: AnyObject {
    func navigateBack()
    func navigateToMovieDetailScreen(_ movieId: Int)
}
