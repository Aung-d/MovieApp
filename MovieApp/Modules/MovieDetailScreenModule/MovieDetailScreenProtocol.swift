//
//  MovieDetailScreenProtocol.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import Foundation

// MARK: - Presenter -> View
protocol MovieDetailScreenPresenterToViewProtocol: AnyObject {
    func showLoading(_ isLoading: Bool)
    var movieDetail: MovieDetailResponse? { get set }
    var casts: [Cast] { get set }
    func showToatMessage(_ message: String)
}

// MARK: - View -> Presenter
protocol MovieDetailScreenViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
    func onBackButtonClicked()
    func onPlayButtonClicked()
}

// MARK: - Interactor -> Presenter
protocol MovieDetailScreenInteractorToPresenterProtocol: AnyObject {
    func onSuccess(_ movieDetail: MovieDetailResponse)
    func onCastSuccess(_ casts: [Cast])
    func onFailure(_ message: String)
    func onFinishedFetch()
}

// MARK: - Presenter -> Interactor
protocol MovieDetailScreenPresenterToInteractorProtocol: AnyObject {
    func fetchMovieData()
    func getVideoInfos() -> [VideoInfo]
    func getPosterPath() -> String
}

// MARK: - Presenter -> Router or WireFrame
protocol MovieDetailScreenPresenterToRouterProtocol: AnyObject {
    func navigateBack()
    func navigateToPlayerScreen(_ posterPath: String,_ videoInfos: [VideoInfo])
}
