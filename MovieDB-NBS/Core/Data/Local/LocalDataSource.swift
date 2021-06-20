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
//    func getListComingSoonMovies() -> Observable<[ComingSoonEntity]>
    func getPopularDetailMovie(id: Int) -> Observable<MovieEntity>
//    func getComingSoonDetailMovie(id: Int) -> Observable<ComingSoonEntity>
    func getFavoriteMovie() -> Observable<[MovieEntity]>
    func addPopularMovies(from movies: [MovieEntity]) -> Observable<Bool>
//    func addComingSoonMovies(from movies: [ComingSoonEntity]) -> Observable<Bool>
    func getListComingSoonMovies() -> Observable<[MovieEntity]>
    func addDetailMovie(from movies: MovieEntity) -> Observable<Bool>
    func searchFavoriteMovie(query: String) -> Observable<[MovieEntity]>
    func searchPopularMovie(query: String) -> Observable<[MovieEntity]>
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
    
    func searchFavoriteMovie(query: String) -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create { observer in
            if let realm = self.realm {
                let movieEntities: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .filter("favorite = \(true)", "title = '\(query)'")
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(movieEntities.toArray(ofType: MovieEntity.self))
                observer.onCompleted()
            }
            else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    func searchPopularMovie(query: String) -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create{observer in
            if let realm = self.realm {
                let movieEntities: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .filter("title = '\(query)'")
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(movieEntities.toArray(ofType: MovieEntity.self))
                observer.onCompleted()
            }
            else {
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
                        .filter("releaseDate = '2022'")
                        .sorted(byKeyPath: "title", ascending: true)
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
    
//    func addComingSoonMovies(from movies: [ComingSoonEntity]) -> Observable<Bool> {
//        <#code#>
//    }
//
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
    
//    func getListComingSoonMovies() -> Observable<[ComingSoonEntity]> {
//        return Observable<[ComingSoonEntity]>.create{ observer in
//            if let realm = self.realm{
//                let movieEntities: Results<ComingSoonEntity> = {
//                    realm.objects(ComingSoonEntity.self)
//                        .sorted(byKeyPath: "title", ascending: true)
//                }()
//                observer.onNext(movieEntities.toArray(ofType: ComingSoonEntity.self))
//                observer.onCompleted()
//            } else {
//                observer.onError(DatabaseError.invalidInstance)
//            }
//            return Disposables.create()
//        }
//    }
    
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
    
//    func getComingSoonDetailMovie(id: Int) -> Observable<ComingSoonEntity> {
//        return Observable<ComingSoonEntity>.create{ observer in
//            if let realm = self.realm {
//                let movies: Results<ComingSoonEntity> = {
//                    realm.objects(ComingSoonEntity.self)
//                        .filter("id = \(id)")
//                }()
//                if let movie = movies.first {
//                    observer.onNext(movie)
//                    observer.onCompleted()
//                } else {
//                    observer.onError(DatabaseError.requestFailed)
//                }
//            } else {
//                observer.onError(DatabaseError.invalidInstance)
//            }
//            return Disposables.create()
//        }
//    }
    
    
}
