//
//  MovieRepository.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 17/06/21.
//

import Foundation
import RxSwift
import RealmSwift

protocol MovieRepositoryProtocol: AnyObject {
    func getBannerList() -> Observable<[MovieModel]>
    func getPopularMovieList() -> Observable<[MovieModel]>
    func getComingSoonList() -> Observable<[MovieModel]>
    func getDetailMovie(id: Int) -> Observable<MovieModel>
//    func getComingSoonDetail(id: Int) -> Observable<MovieModel>
    func getFavoriteMovie() -> Observable<[MovieModel]>
    func searchPopularMovie(query: String) -> Observable<[MovieModel]>
    func searchFavoriteMovie(query: String) -> Observable<[MovieModel]>
    
}

class MovieRepository: NSObject {
    typealias MovieInstance = (LocalDataSource, RemoteDataSource) -> MovieRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSource
    
    private init(local: LocalDataSource, remote: RemoteDataSource) {
        self.local = local
        self.remote = remote
    }
    
    static let sharedInstance: MovieInstance = { localRepo, remoteRepo in
        return MovieRepository(local: localRepo, remote: remoteRepo)
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    func searchPopularMovie(query: String) -> Observable<[MovieModel]> {
        return self.local.searchPopularMovie(query: query)
            .map{MovieMapper.mapListPopularMovieEntityToDomain(input: $0)}
    }
    
    func searchFavoriteMovie(query: String) -> Observable<[MovieModel]> {
        return self.local.searchFavoriteMovie(query: query)
            .map{MovieMapper.mapListPopularMovieEntityToDomain(input: $0)}
    }
    
    func getBannerList() -> Observable<[MovieModel]> {
        return self.local.getListPopularMovies()
            .take(3)
            .map{ MovieMapper.mapListPopularMovieEntityToDomain(input: $0)}
            .filter{ !$0.isEmpty}
            .ifEmpty(switchTo: self.remote.getPopularMovies()
                        .map{ MovieMapper.mapListPopularMovieResponseToEntity(input: $0)}
                        .flatMap{ self.local.addPopularMovies(from: $0)}
                        .filter{$0}
                        .flatMap{ _ in self.local.getListPopularMovies()
                        .take(3)
                        .map{ MovieMapper.mapListPopularMovieEntityToDomain(input: $0)}
            })
    }
    
    func getPopularMovieList() -> Observable<[MovieModel]> {
        return self.local.getListPopularMovies()
            .map{ MovieMapper.mapListPopularMovieEntityToDomain(input: $0)}
            .filter{ !$0.isEmpty}
            .ifEmpty(switchTo: self.remote.getPopularMovies()
                        .map{ MovieMapper.mapListPopularMovieResponseToEntity(input: $0)}
                        .flatMap{ self.local.addPopularMovies(from: $0)}
                        .filter{$0}
                        .flatMap{ _ in self.local.getListPopularMovies()
                        .map { MovieMapper.mapListPopularMovieEntityToDomain(input: $0)}
                
            })
    }
    
    func getComingSoonList() -> Observable<[MovieModel]> {
        return self.local.getListComingSoonMovies()
            .take(10)
            .map{ MovieMapper.mapListPopularMovieEntityToDomain(input: $0)}
            .filter{ !$0.isEmpty}
            .ifEmpty(switchTo:
                        self.remote.getComingSoonMovies()
                        .map{MovieMapper.mapListPopularMovieResponseToEntity(input: $0)}
                        .flatMap{self.local.addPopularMovies(from: $0)}
                        .filter{$0}
                        .flatMap{ _ in self.local.getListComingSoonMovies()
                        .take(10)
                        .map{MovieMapper.mapListPopularMovieEntityToDomain(input: $0)}
            })
    }
    
    func getDetailMovie(id: Int) -> Observable<MovieModel> {
        return self.local.getPopularDetailMovie(id: id)
            .map{MovieMapper.mapDetailEntityToDomain(input: $0)}
            .filter{!$0.genre.isEmpty}
            .ifEmpty(switchTo: self.remote.getDetailMovie(id: id)
                        .map{MovieMapper.mapDetailResponseToEntity(input: $0)}
                        .flatMap{ self.local.addDetailMovie(from: $0)}
                        .filter{$0}
                        .flatMap{_ in self.local.getPopularDetailMovie(id: id)
                        .map{MovieMapper.mapDetailEntityToDomain(input: $0)}
            })
    }
    
//    func getComingSoonDetail(id: Int) -> Observable<MovieModel> {
//        <#code#>
//    }
    
    func getFavoriteMovie() -> Observable<[MovieModel]> {
        return self.local.getFavoriteMovie()
            .map{ MovieMapper.mapListPopularMovieEntityToDomain(input: $0)}
    }
}
