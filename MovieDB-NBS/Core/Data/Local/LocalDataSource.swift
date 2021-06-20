//
//  LocalDataSource.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 17/06/21.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocalDataSourceProtocol: AnyObject {
    func getListPopularMovies() -> Observable<[MovieEntity]>
    func getPopularDetailMovie(id: Int) -> Observable<MovieEntity>
    func getFavoriteMovie() -> Observable<[MovieEntity]>
    func addPopularMovies(from movies: [MovieEntity]) -> Observable<Bool>
    func getListComingSoonMovies() -> Observable<[MovieEntity]>
    func addDetailMovie(from movies: MovieEntity) -> Observable<Bool>
    func updateFavoriteStatusFromDetail(id: Int) -> Observable<MovieEntity>
}

class LocalDataSource: NSObject{
    private let realm: Realm?
    
    private init(realm: Realm?){
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
        return LocalDataSource(realm: realmDatabase)
    }
}

extension LocalDataSource: LocalDataSourceProtocol{
    
    func updateFavoriteStatusFromDetail(id: Int) -> Observable<MovieEntity> {
        return Observable<MovieEntity>.create{ observer in
            if let realm = self.realm, let movieEntity = {
                realm.objects(MovieEntity.self).filter("id = \(id)")
            }().first {
                do {
                    try realm.write{
                        movieEntity.setValue(!movieEntity.favorite, forKey: "favorite")
                    }
                    observer.onNext(movieEntity)
                    observer.onCompleted()
                }catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getListComingSoonMovies() -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create{ observer in
            if let realm = self.realm{
                let movieEntities: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .filter("releaseDate CONTAINS '2022'")
                        .sorted(byKeyPath: "backdropPath", ascending: false)
                }()
                observer.onNext(movieEntities.toArray(ofType: MovieEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addDetailMovie(from movies: MovieEntity) -> Observable<Bool> {
        return Observable<Bool>.create{ observer in
            if let realm = self.realm {
                do {
                    try realm.write{
                        realm.add(movies, update: .modified)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addPopularMovies(from movies: [MovieEntity]) -> Observable<Bool> {
        return Observable<Bool>.create{ observer in
            if let realm = self.realm {
                do {
                    try realm.write{
                        for movie in movies {
                            realm.add(movie,update: .all)
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getFavoriteMovie() -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create{ observer in
            if let realm = self.realm {
                let movieEntity = {
                    realm.objects(MovieEntity.self)
                        .filter("favorite = \(true)")
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(movieEntity.toArray(ofType: MovieEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getListPopularMovies() -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create{ observer in
            if let realm = self.realm{
                let movieEntity: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .sorted(byKeyPath: "backdropPath", ascending: false)
                }()
                observer.onNext(movieEntity.toArray(ofType: MovieEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getPopularDetailMovie(id: Int) -> Observable<MovieEntity> {
        return Observable<MovieEntity>.create{ observer in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .filter("id = \(id)")
                }()
                if let movie = movies.first {
                    observer.onNext(movie)
                    observer.onCompleted()
                } else {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    
}
