//
//  MovieAPI.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import Foundation
import Moya

enum MovieAPI {
    case nowPlaying(Int), popular(Int), topRated(Int), upcoming(Int),
    searchMovie(String), movieDetail(Int), credits(Int), videos(Int)
}


extension MovieAPI: TargetType {
    var baseURL: URL {
        guard let url =  URL(string: NetworkConstant.BASE_URL) else {
            fatalError()
        }
       return url
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            NetworkConstant.NOW_PLAYING_PATH
        case .popular:
            NetworkConstant.POPULAR_PATH
        case .topRated:
            NetworkConstant.TOP_RATED_PATH
        case .upcoming:
            NetworkConstant.UPCOMING_PATH
        case .searchMovie:
            NetworkConstant.SEARCH_MOVIE
        case .movieDetail(let id):
            "\(NetworkConstant.MOVIE_DETAIL)\(id)"
        case .credits(let id):
            "\(NetworkConstant.MOVIE_DETAIL)\(id)/credits"
        case .videos(let id):
            "\(NetworkConstant.MOVIE_DETAIL)\(id)/videos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .nowPlaying(let page), .popular(let page), .topRated(let page), .upcoming(let page):
            return .requestParameters(
                parameters: [
                    APIKeyParam.API_KEY: NetworkConstant.API_KEY,
                    APIKeyParam.PAGE: page
                ], encoding: URLEncoding.queryString)
            
        case .searchMovie(let query):
            return .requestParameters(
                parameters: [
                    APIKeyParam.API_KEY: NetworkConstant.API_KEY,
                    APIKeyParam.PAGE: 1,
                    APIKeyParam.QUERY: query
                ], encoding: URLEncoding.queryString)
            
        case .movieDetail, .credits, .videos:
            return .requestParameters(
                parameters: [
                    APIKeyParam.API_KEY: NetworkConstant.API_KEY,
                ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [APIKeyParam.CONTENT_TYPE: NetworkConstant.APPLICATION_JSON]
    }
    
    
}
