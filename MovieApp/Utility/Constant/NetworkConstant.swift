//
//  NetworkConstant.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import Foundation

struct NetworkConstant {
    
    static let BASE_URL = "https://api.themoviedb.org/3/"
    static let API_KEY = "9f04c49e56282d595c3ac1fa31ea742d"
    static let APPLICATION_JSON = "application/json"
    static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w780/"
    static let TRAILER_BASE_URL = "https://www.youtube.com/watch?v="
    
    static let NOW_PLAYING_PATH = "movie/now_playing"
    static let POPULAR_PATH = "movie/popular"
    static let TOP_RATED_PATH = "movie/top_rated"
    static let UPCOMING_PATH = "movie/upcoming"
    static let SEARCH_MOVIE = "search/movie"
    static let MOVIE_DETAIL = "movie/"
    
}

struct APIKeyParam {
    static let API_KEY = "api_key"
    static let PAGE = "page"
    static let CONTENT_TYPE = "Content-type"
    static let QUERY = "query"
}
