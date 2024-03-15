//
//  PlayerScreenInteractor.swift
//  MovieApp
//
//  Created by Winter on 3/15/24.
//

import Foundation


class TrailerScreenInteractor {
    
    var presenter: TrailerScreenInteractorToPresenterProtocol?
    private let posterPath: String
    private let videoInfos: [VideoInfo]
    
    init(_ posterPath: String,_ videoInfos: [VideoInfo]) {
        self.posterPath = posterPath
        self.videoInfos = videoInfos
    }
}



// MARK: - Presenter -> Interactor
extension TrailerScreenInteractor: TrailerScreenPresenterToInteractorProtocol {
    
    func getPosterPath() -> String {
        return posterPath
    }
    
    func getVideoInfos() -> [VideoInfo] {
        return videoInfos
    }
    
}
