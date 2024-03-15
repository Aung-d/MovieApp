//
//  MovieListScreenInteractor.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import Foundation


class MovieListScreenInteractor {
    
    var presenter: MovieListScreenInteractorToPresenterProtocol?
    
    var title: String
    private var page: Int = 0
    private var isFetching = false
    private var totalPage: Int = 1
    
    init(_ title: String) {
        self.title = title
    }
    
    func fetchMovies( _ isPaging: Bool) {
        if !isFetching {
            if page > totalPage {
                presenter?.noMorePagingData()
                return
            }
            isFetching = true
            page += 1
            switch title {
            case MovieHeader.NOW_PLAYING:
                fetchNowPlayingList(page, isPaging)
                
            case MovieHeader.POPULAR:
                fetchPopular(page, isPaging)
                
            case MovieHeader.TOP_RATE:
                fetchTopRated(page, isPaging)
                
            default: fetchUpcoming(page, isPaging)
            }
        }
    }
    
    private func fetchNowPlayingList(_ page: Int, _ isPaging: Bool) {
        NetworkService.shared.performRequest(
            .nowPlaying(page),
            MovieResponse.self,
            onSuccess: { response in
                self.totalPage = response.totalPage
                self.presenter?.onSuccess(response.results, isPaging)
                self.isFetching = false
            },
            onFailure: { errorMessage in
                self.presenter?.onFailure(errorMessage, isPaging)
                self.isFetching = false
            })
    }
    
    private func fetchPopular(_ page: Int, _ isPaging: Bool) {
        NetworkService.shared.performRequest(
            .popular(page),
            MovieResponse.self,
            onSuccess: { response in
                self.totalPage = response.totalPage
                self.presenter?.onSuccess(response.results, isPaging)
                self.isFetching = false
            },
            onFailure: { errorMessage in
                self.presenter?.onFailure(errorMessage, isPaging)
                self.isFetching = false
            })
    }
    
    private func fetchTopRated(_ page: Int, _ isPaging: Bool) {
        NetworkService.shared.performRequest(
            .topRated(page),
            MovieResponse.self,
            onSuccess: { response in
                self.totalPage = response.totalPage
                self.presenter?.onSuccess(response.results, isPaging)
                self.isFetching = false
            },
            onFailure: { errorMessage in
                self.presenter?.onFailure(errorMessage, isPaging)
                self.isFetching = false
            })
    }
    
    private func fetchUpcoming(_ page: Int, _ isPaging: Bool) {
        NetworkService.shared.performRequest(
            .upcoming(page),
            MovieResponse.self,
            onSuccess: { response in
                self.totalPage = response.totalPage
                self.presenter?.onSuccess(response.results, isPaging)
                self.isFetching = false
            },
            onFailure: { errorMessage in
                self.presenter?.onFailure(errorMessage, isPaging)
                self.isFetching = false
            })
    }
    
}

// MARK: - Presenter -> Interactor
extension MovieListScreenInteractor: MovieListScreenPresenterToInteractorProtocol {
    
    
    
}
