//
//  MovieMapper.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 17/06/21.
//
import RealmSwift
import Foundation

final class MovieMapper {
    
    static func mapListPopularMovieResponseToEntity(
        input movieResponse: [MovieResponse]
    ) -> [MovieEntity] {
        return movieResponse.map{ result in
            let movieEntity = MovieEntity()
            movieEntity.id = result.id ?? 0
            movieEntity.title = result.title ?? ""
            movieEntity.overview = result.overview ?? ""
            movieEntity.posterPath = result.posterPath ?? ""
            movieEntity.backdropPath = result.backdropPath ?? ""
            movieEntity.voteAverage = result.voteAverage ?? 0
            movieEntity.releaseDate = result.releaseDate ?? ""
            
            return movieEntity
        }
    }
    
    static func mapListPopularMovieEntityToDomain(
        input movieEntity: [MovieEntity]
    ) -> [MovieModel] {
        return movieEntity.map{result in
            return MovieModel(
                id: result.id,
                title: result.title,
                overview: result.overview,
                posterPath: result.posterPath,
                backdropPath: result.backdropPath,
                voteAverage: result.voteAverage,
                releaseDate: result.releaseDate,
                runtime: 0,
                genre: [],
                favorite: result.favorite
            )
        }
    }
    
    static func mapListComingSoonMovieResponseToEntity(
        input movieResponse: [MovieResponse]
    ) -> [ComingSoonEntity] {
        return movieResponse.map { result in
            let movieEntity = ComingSoonEntity()
            movieEntity.id = result.id ?? 0
            movieEntity.title = result.title ?? ""
            movieEntity.overview = result.overview ?? ""
            movieEntity.posterPath = result.posterPath ?? ""
            movieEntity.backdropPath = result.backdropPath ?? ""
            movieEntity.voteAverage = result.voteAverage ?? 0
            movieEntity.releaseDate = result.releaseDate ?? ""
            return movieEntity
        }
    }
    
    static func mapListComingSoonEntityToDomain(
        input movieEntity: [ComingSoonEntity]
    ) -> [MovieModel] {
        return movieEntity.map { result in
            return MovieModel(
                id: result.id,
                title: result.title,
                overview: result.overview,
                posterPath: result.posterPath,
                backdropPath: result.backdropPath,
                voteAverage: result.voteAverage,
                releaseDate: result.releaseDate,
                runtime: 0,
                genre: [],
                favorite: result.favorite
            )
        }
    }
    
    static func mapDetailResponseToEntity(
        input movieResponse: DetailMovieResponse
    ) -> MovieEntity {
        let genres = List<GenreEntity>()
        movieResponse.genre?.map{ result in
            let genre = GenreEntity()
            genre.id = result.id ?? 0
            genre.name = result.name ?? ""
            genres.append(genre)
        }
        let movieEntity = MovieEntity()
        movieEntity.id = movieResponse.id ?? 0
        movieEntity.title = movieResponse.title ?? ""
        movieEntity.overview = movieResponse.overview ?? ""
        movieEntity.posterPath = movieResponse.posterPath ?? ""
        movieEntity.backdropPath = movieResponse.backdropPath ?? ""
        movieEntity.voteAverage = movieResponse.voteAverage ?? 0
        movieEntity.releaseDate = movieResponse.releaseDate ?? ""
        movieEntity.runtime = movieResponse.runtime ?? 0
        movieEntity.genre = genres
        return movieEntity
    }
    
    static func mapDetailEntityToDomain(
        input movieEntity: MovieEntity
    ) -> MovieModel {
        let genre = GenreMapper.mapGenreEntitiesToDomains(input: movieEntity.genre.map{$0})
        
        return MovieModel(
            id: movieEntity.id,
            title: movieEntity.title,
            overview: movieEntity.overview,
            posterPath: movieEntity.posterPath,
            backdropPath: movieEntity.backdropPath,
            voteAverage: movieEntity.voteAverage,
            releaseDate: movieEntity.releaseDate,
            runtime: movieEntity.runtime,
            genre: genre,
            favorite: movieEntity.favorite
        )
    }
}
