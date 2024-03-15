//
//  MoviesListScreenProtocol.swift
//  MoviesViwer
//
//  Created by Winter on 3/13/24.
//

import Foundation

// MARK: - Presenter -> View
protocol HomeScreenPresenterToViewProtocol: AnyObject {
    var collectionViewHeaders: [String] { get set }
    var nowPlayingMovieData: [MovieData] { get set }
    var popularMovieData: [MovieData] { get set }
    var topRatedMovieData: [MovieData] { get set }
    var upcomingMovieData: [MovieData] { get set }
    var searchMovieData: [MovieData] { get set }
    func showLoading(_ isLoading: Bool)
    func showToatMessage(_ message: String)
}

// MARK: - View -> Presenter
protocol HomeScreenViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
    func onSearchButtonClicked(_ query: String)
    func onCollectionViewHeaderButtonClicked(_ title: String)
    func onMovieItemClicked(_ movieId: Int)
    func onRefreshData()
}

// MARK: - Interactor -> Presenter
protocol HomeScreenInteractorToPresenterProtocol: AnyObject {
    func onNowPlayingSuccess(_ movies: [MovieData])
    func onPopularSuccess(_ movies: [MovieData])
    func onTopRatedSuccess(_ movies: [MovieData])
    func onUpcomingSuccess(_ movies: [MovieData])
    func onSearchMovieSuccess(_ movies: [MovieData])
    func onFailure(_ message: String)
    func finishedFetchMovies()
}

// MARK: - Presenter -> Interactor
protocol HomeScreenPresenterToInteractorProtocol: AnyObject {
    func getHeaders() -> [String]
    func searchMovie(_ query: String)
    func fetchMovies()
    func fetchLocalMovies()
}

// MARK: - Presenter -> Router or WireFrame
protocol HomeScreenPresenterToRouterProtocol: AnyObject {
    func navigateToMovieListScreen(_ title: String)
    func navigateToMovieDetailScreen(_ movieId: Int)
}
