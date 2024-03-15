//
//  MovieDetailScreenEntity.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import Foundation

enum MovieDetailScreenButtonTag: Int{
    case BACK_BUTTON = 0
    case PLAY_TRAILER_BUTTON = 1
}

struct MovieDetailResponse: Codable {
    let id: Int
    let backdropPath: String?
    let posterPath: String?
    let genres: [Genre]
    let overview: String
    let releaseDate: String
    let runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status: String
    let title: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case genres
        case overview
        case releaseDate = "release_date"
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case title
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
    
    func getBackdropPath() -> String {
        return NetworkConstant.IMAGE_BASE_URL + (backdropPath ?? "")
    }
    
    func getPosterPath() -> String {
        return NetworkConstant.IMAGE_BASE_URL + (posterPath ?? "")
    }
}
        
struct Genre: Codable {
    let name: String
}

struct SpokenLanguage: Codable {
    let name: String
}

struct CreditResponse: Decodable {
    let cast: [Cast]
}

struct Cast: Decodable {
    let profilePath: String?
    let name: String
    
    enum CodingKeys:String, CodingKey {
        case profilePath = "profile_path"
        case name
    }
    
    func getImagePath() -> String {
        return NetworkConstant.IMAGE_BASE_URL + (profilePath ?? "")
    }
}

struct VideoResponse: Codable {
    let results: [VideoInfo]
}

struct VideoInfo: Codable {
    let key: String
    let name: String
    let publishedAt: String
    
    enum CodingKeys: String, CodingKey {
        case key
        case name
        case publishedAt = "published_at"
    }
}
