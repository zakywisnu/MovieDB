//
//  DetailMovieResponse.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 17/06/21.
//

import Foundation

struct DetailMovieResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case overview = "overview"
        case genre = "genres"
        case runtime = "runtime"
    }
    
    let id: Int?
    let title: String?
    let voteAverage: Double?
    let posterPath: String?
    let releaseDate: String?
    let backdropPath: String?
    let overview: String?
    let genre: [Genre]?
    let runtime: Int?
}

struct Genre: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    let id: Int?
    let name: String?
}
