//
//  RemoteDataSource.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 17/06/21.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: AnyObject {
    func getPopularMovies() -> Observable<[MovieResponse]>
    func getComingSoonMovies() -> Observable<[MovieResponse]>
//    func getDetailComingSoonMovie(id: Int) -> Observable<DetailMovieResponse>
    func getDetailMovie(id: Int) -> Observable<DetailMovieResponse>
}

class RemoteDataSource: NSObject {
    private override init() { }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol{
    func getPopularMovies() -> Observable<[MovieResponse]> {
        return Observable<[MovieResponse]>.create{ observer in
            if let url = URL(string: Endpoints.Gets.popular.url){
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MovieListResponse.self) { response in
                        switch response.result{
                        case .success(let value):
                            observer.onNext(value.results)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func getComingSoonMovies() -> Observable<[MovieResponse]> {
        return Observable<[MovieResponse]>.create{ observer in
            if let url = URL(string: Endpoints.Gets.popular.url + "&year=2022"){
                print("url", url)
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MovieListResponse.self){ response in
                        switch response.result{
                        case .success(let value):
                            observer.onNext(value.results)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
//    func getDetailComingSoonMovie(id: Int) -> Observable<DetailMovieResponse> {
//        return Observable<DetailMovieResponse>.create{ observer in
//            if let url = URL(string: Endpoints.Gets.detailMovie(id: id).url){
//                AF.request(url)
//                    .
//            }
//            return Disposables.create()
//        }
//    }
    
    func getDetailMovie(id: Int) -> Observable<DetailMovieResponse> {
        return Observable<DetailMovieResponse>.create{ observer in
            if let url = URL(string: Endpoints.Gets.detailMovie(id: id).url){
                AF.request(url)
                    .validate()
                    .responseDecodable(of: DetailMovieResponse.self){ response in
                        switch response.result{
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    
}
