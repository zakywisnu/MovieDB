//
//  MovieModel.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 17/06/21.
//

import Foundation

struct MovieModel: Equatable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let backdropPath: String
    let voteAverage: Double
    let releaseDate: String
    let runtime: Int
    let genre: [GenreModel]
    let favorite: Bool
    
}

struct GenreModel: Equatable {
    let id: Int
    let name: String
}
