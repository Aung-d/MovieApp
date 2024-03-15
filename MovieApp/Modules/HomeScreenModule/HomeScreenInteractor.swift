//
//  MoviesListScreenInteractor.swift
//  MoviesViwer
//
//  Created by Winter on 3/13/24.
//

import Foundation

class HomeScreenInteractor {
    
    var presenter: HomeScreenInteractorToPresenterProtocol?
    private let headers = [
        MovieHeader.NOW_PLAYING, MovieHeader.POPULAR,
        MovieHeader.TOP_RATE, MovieHeader.UPCOMING]
    private let dispatchGroup = DispatchGroup()
    
    func fetchMovies() {
        fetchNowPlayingList()
        fetchPopular()
        fetchTopRated()
        fetchUpcoming()
        
        dispatchGroup.notify(queue: .main) {
            self.presenter?.finishedFetchMovies()
        }
    }
    
    private func fetchNowPlayingList() {
        dispatchGroup.enter()
        NetworkService.shared.performRequest(
            .nowPlaying(1),
            MovieResponse.self,
            onSuccess: { response in
                self.saveNowPlayingMovie(response.results)
                self.presenter?.onNowPlayingSuccess(response.results)
                self.dispatchGroup.leave()
            },
            onFailure: { errorMessage in
                self.presenter?.onFailure(errorMessage)
                self.dispatchGroup.leave()
            })
        
    }
    
    private func saveNowPlayingMovie(_ movies: [MovieData]) {
        CoreDataService.shared.deletAllNowPlayingData()
        movies.forEach { movie in
            CoreDataService.shared.nowPlayingMovie(Int64(movie.id), movie.title, movie.posterPath)
        }
        CoreDataService.shared.save()
    }
    
    private func fetchPopular() {
        dispatchGroup.enter()
        NetworkService.shared.performRequest(
            .popular(1),
            MovieResponse.self,
            onSuccess: { response in
                self.savePopularMovie(response.results)
                self.presenter?.onPopularSuccess(response.results)
                self.dispatchGroup.leave()
            },
            onFailure: { errorMessage in
                self.presenter?.onFailure(errorMessage)
                self.dispatchGroup.leave()
            })
    }
    
    private func savePopularMovie(_ movies: [MovieData]) {
        CoreDataService.shared.deletAllPopulaData()
        movies.forEach { movie in
            CoreDataService.shared.popularMovie(Int64(movie.id), movie.title, movie.posterPath)
        }
        CoreDataService.shared.save()
    }
    
    private func fetchTopRated() {
        dispatchGroup.enter()
        NetworkService.shared.performRequest(
            .topRated(1),
            MovieResponse.self,
            onSuccess: { response in
                self.saveTopRatedMovie(response.results)
                self.presenter?.onTopRatedSuccess(response.results)
                self.dispatchGroup.leave()
            },
            onFailure: { errorMessage in
                self.presenter?.onFailure(errorMessage)
                self.dispatchGroup.leave()
            })
    }
    
    private func saveTopRatedMovie(_ movies: [MovieData]) {
        CoreDataService.shared.deletAllTopRatedData()
        movies.forEach { movie in
            CoreDataService.shared.topRatedMovie(Int64(movie.id), movie.title, movie.posterPath)
        }
        CoreDataService.shared.save()
    }
    
    private func fetchUpcoming() {
        dispatchGroup.enter()
        NetworkService.shared.performRequest(
            .upcoming(1),
            MovieResponse.self,
            onSuccess: { response in
                self.saveUpcomingMovie(response.results)
                self.presenter?.onUpcomingSuccess(response.results)
                self.dispatchGroup.leave()
            },
            onFailure: { errorMessage in
                self.presenter?.onFailure(errorMessage)
                self.dispatchGroup.leave()
            })
    }
    
    private func saveUpcomingMovie(_ movies: [MovieData]) {
        CoreDataService.shared.deletAllUpcomingData()
        movies.forEach { movie in
            CoreDataService.shared.upcomingMovie(Int64(movie.id), movie.title, movie.posterPath)
        }
        CoreDataService.shared.save()
    }
    
    func searchMovie(_ query: String) {
        NetworkService.shared.performRequest(
            .searchMovie(query),
            MovieResponse.self,
            onSuccess: { response in
                self.presenter?.onSearchMovieSuccess(response.results)
            },
            onFailure: { errorMessage in
                self.presenter?.onFailure(errorMessage)
            })
    }
    
    func fetchLocalMovies() {
        let nowPlayingMovies = CoreDataService.shared.fetchNowPlayingMovie()
            .map({ MovieData(id: Int($0.id), title: $0.title ?? "", posterPath: $0.posterPath) })
        presenter?.onNowPlayingSuccess(nowPlayingMovies)
        
        let popularMovies = CoreDataService.shared.fetchPopularMovie()
            .map({ MovieData(id: Int($0.id), title: $0.title ?? "", posterPath: $0.posterPath) })
        presenter?.onPopularSuccess(popularMovies)
        
        let topRateMovies = CoreDataService.shared.fetchTopRatedMovie()
            .map({ MovieData(id: Int($0.id), title: $0.title ?? "", posterPath: $0.posterPath) })
        presenter?.onTopRatedSuccess(topRateMovies)
        
        let upcomingMovies = CoreDataService.shared.fetchUpcomingMovie()
            .map({ MovieData(id: Int($0.id), title: $0.title ?? "", posterPath: $0.posterPath) })
        presenter?.onUpcomingSuccess(upcomingMovies)
    }
    
}

// MARK: - Presenter -> Interactor
extension HomeScreenInteractor: HomeScreenPresenterToInteractorProtocol {
    
    func getHeaders() -> [String] {
        return headers
    }
}
