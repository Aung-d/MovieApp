//
//  PlayerScreenPresenter.swift
//  MovieApp
//
//  Created by Winter on 3/15/24.
//

import Foundation

class TrailerScreenPresenter {
    
    private weak var view: TrailerScreenPresenterToViewProtocol?
    private let interactor: TrailerScreenPresenterToInteractorProtocol
    private let router: TrailerScreenPresenterToRouterProtocol
    
    init(_ view: TrailerScreenPresenterToViewProtocol?,_ interactor: TrailerScreenPresenterToInteractorProtocol,_ router: TrailerScreenPresenterToRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - View -> Presneter
extension TrailerScreenPresenter: TrailerScreenViewToPresenterProtocol {
    
    func getPosterPath() -> String {
        return interactor.getPosterPath()
    }
 
    func onBackButtonClicked() {
        router.navigateBack()
    }
    
    func viewDidLoad() {
        view?.videoInfos = interactor.getVideoInfos()
    }
}


// MARK: - Interactor -> Presneter
extension TrailerScreenPresenter: TrailerScreenInteractorToPresenterProtocol {
    
}
    
