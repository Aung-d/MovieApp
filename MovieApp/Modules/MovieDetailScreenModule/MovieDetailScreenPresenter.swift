//
//  MovieDetailScreenPresenter.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import Foundation

class MovieDetailScreenPresenter {
    
    private weak var view: MovieDetailScreenPresenterToViewProtocol?
    private let interactor: MovieDetailScreenPresenterToInteractorProtocol
    private let router: MovieDetailScreenPresenterToRouterProtocol
    
    init(_ view: MovieDetailScreenPresenterToViewProtocol?,_ interactor: MovieDetailScreenPresenterToInteractorProtocol,_ router: MovieDetailScreenPresenterToRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - View -> Presneter
extension MovieDetailScreenPresenter: MovieDetailScreenViewToPresenterProtocol {
    
    func viewDidLoad() {
        view?.showLoading(true)
        interactor.fetchMovieData()
    }
    
    func onBackButtonClicked() {
        router.navigateBack()
    }

    func onPlayButtonClicked() {
        router.navigateToPlayerScreen(interactor.getPosterPath(), interactor.getVideoInfos())
    }
    
}


// MARK: - Interactor -> Presneter
extension MovieDetailScreenPresenter: MovieDetailScreenInteractorToPresenterProtocol {
    
    func onSuccess(_ movieDetail: MovieDetailResponse) {
        view?.movieDetail = movieDetail
    }
    
    func onFailure(_ message: String) {
        view?.showLoading(false)
        view?.showToatMessage(message)
    }
    
    func onFinishedFetch() {
        view?.showLoading(false)
    }
    
    func onCastSuccess(_ casts: [Cast]) {
        view?.casts = Array(casts.prefix(8))
    }
}
