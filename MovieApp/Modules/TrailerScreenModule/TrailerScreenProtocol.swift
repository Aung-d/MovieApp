//
//  PlayerScreenProtocol.swift
//  MovieApp
//
//  Created by Winter on 3/15/24.
//

import Foundation

// MARK: - Presenter -> View
protocol TrailerScreenPresenterToViewProtocol: AnyObject {
    var videoInfos: [VideoInfo] { get set }
}

// MARK: - View -> Presenter
protocol TrailerScreenViewToPresenterProtocol: AnyObject {
    func getPosterPath() -> String
    func onBackButtonClicked()
    func viewDidLoad()
}

// MARK: - Interactor -> Presenter
protocol TrailerScreenInteractorToPresenterProtocol: AnyObject {
   
}

// MARK: - Presenter -> Interactor
protocol TrailerScreenPresenterToInteractorProtocol: AnyObject {
    func getPosterPath() -> String
    func getVideoInfos() -> [VideoInfo]
}

// MARK: - Presenter -> Router or WireFrame
protocol TrailerScreenPresenterToRouterProtocol: AnyObject {
    func navigateBack()
}
