//
//  PlayerScreenRouter.swift
//  MovieApp
//
//  Created by Winter on 3/15/24.
//

import Foundation

class TrailerScreenRouter: BaseRouter<TrailerScreenViewController> {
    
    init(_ posterPath: String,_ videoInfos: [VideoInfo]) {
        super.init(storyboardName: StoryboardName.TRAILER_SCREEN, type: TrailerScreenViewController.self)
        let interactor = TrailerScreenInteractor(posterPath, videoInfos)
        let presenter = TrailerScreenPresenter(viewController, interactor, self)
        interactor.presenter = presenter
        viewController.presenter = presenter
        
    }
    
}

// MARK: - Presenter -> Router
extension TrailerScreenRouter: TrailerScreenPresenterToRouterProtocol {
    
    func navigateBack() {
        self.popViewController()
    }
}
