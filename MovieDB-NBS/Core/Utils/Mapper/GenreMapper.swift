//
//  GenreMapper.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 17/06/21.
//

import Foundation
import RealmSwift

final class GenreMapper {
    static func mapGenreResponsesToEntities(
        input genreResponse: [Genre]
    ) -> [GenreEntity] {
        return genreResponse.map{ result in
            let genreEntity = GenreEntity()
            genreEntity.id = result.id ?? 0
            genreEntity.name = result.name ?? ""
            return genreEntity
        }
    }
    
    static func mapGenreEntitiesToDomains(
        input genreEntity: [GenreEntity]
    ) -> [GenreModel] {
        return genreEntity.map { result in
            GenreModel(id: result.id, name: result.name)
        }
    }
    
    static func mapGenreResponseToEntity(
        input genreResponse: Genre
    ) -> GenreEntity {
        let genreEntity = GenreEntity()
        genreEntity.id = genreResponse.id ?? 0
        genreEntity.name = genreResponse.name ?? ""
        return genreEntity
    }
    
    static func mapGenreEntityToDomain(
        input genreEntity: GenreEntity
    ) -> GenreModel {
        return GenreModel(id: genreEntity.id, name: genreEntity.name)
    }
}
