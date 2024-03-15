//
//  MovieDetailScreenInteractor.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import Foundation

class MovieDetailScreenInteractor {
    
    var presenter: MovieDetailScreenInteractorToPresenterProtocol?
    private let movieId: Int
    private var videoInfos: [VideoInfo] = []
    private var posterPath: String = ""
    private let dispatchGroup = DispatchGroup()
    
    init(_ movieId: Int) {
        self.movieId = movieId
    }
    
    func fetchMovieData() {
        fetchMovieDetail()
        fetchCredits()
        fetchVideos()
        
        dispatchGroup.notify(queue: .main) {
            self.presenter?.onFinishedFetch()
        }
    }
    
    private func fetchMovieDetail() {
        dispatchGroup.enter()
        NetworkService.shared.performRequest(
            .movieDetail(movieId),
            MovieDetailResponse.self,
            onSuccess: { response in
                self.presenter?.onSuccess(response)
                self.posterPath = response.getPosterPath()
                self.dispatchGroup.leave()
            },
            onFailure: { error in
                self.presenter?.onFailure(error)
                self.dispatchGroup.leave()
            })
    }
    
    private func fetchCredits() {
        self.dispatchGroup.enter()
        NetworkService.shared.performRequest(
            .credits(movieId),
            CreditResponse.self,
            onSuccess: { response in
                self.presenter?.onCastSuccess(response.cast)
                self.dispatchGroup.leave()
            },
            onFailure: { error in
                self.presenter?.onFailure(error)
                self.dispatchGroup.leave()
            })
    }
    
    private func fetchVideos(){
        self.dispatchGroup.enter()
        NetworkService.shared.performRequest(
            .videos(movieId),
            VideoResponse.self,
            onSuccess: { response in
                self.videoInfos = response.results
                self.dispatchGroup.leave()
            },
            onFailure: { error in
                self.presenter?.onFailure(error)
                self.dispatchGroup.leave()
            })
    }
}


// MARK: - Presenter -> Interactor
extension MovieDetailScreenInteractor: MovieDetailScreenPresenterToInteractorProtocol {
    
    func getVideoInfos() -> [VideoInfo] {
        return videoInfos
    }
    
    func getPosterPath() -> String {
        return posterPath
    }
    
}
