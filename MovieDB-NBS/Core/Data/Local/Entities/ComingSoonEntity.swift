//
//  ComingSoonEntity.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 17/06/21.
//

import Foundation
import RealmSwift

class ComingSoonEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var runtime: Int = 0
    var genre = List<GenreEntity>()
    @objc dynamic var favorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override init() {}
    
    required init(id: Int, title: String, overview: String, posterPath: String, backdropPath: String, voteAverage: Double, releaseDate: String, runtime: Int, genre: [GenreEntity], favorite: Bool) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.genre.append(objectsIn: genre.map{$0})
        self.favorite = favorite
    }
}

