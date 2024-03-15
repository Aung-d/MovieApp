//
//  MoviesListScreenEntity.swift
//  MoviesViwer
//
//  Created by Winter on 3/13/24.
//

import Foundation

struct MovieHeader {
    static let NOW_PLAYING = "Now Playing"
    static let POPULAR = "Popular"
    static let TOP_RATE = "Top Rate"
    static let UPCOMING = "Upcoming"
}

struct MovieResponse: Codable {
    let page: Int
    let totalPage: Int
    let results: [MovieData]
    
    enum CodingKeys:String, CodingKey {
        case page
        case totalPage = "total_pages"
        case results
    }
}

struct MovieData: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    
    enum CodingKeys:String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
    
    func getPosterPath() -> String {
        return NetworkConstant.IMAGE_BASE_URL + (posterPath ?? "")
    }
}


