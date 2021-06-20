//
//  HomeInteractor.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 18/06/21.
//

import Foundation
import RxSwift
protocol HomeUseCase {
    func getBannerList() -> Observable<[MovieModel]>
    func getPopularList() -> Observable<[MovieModel]>
    func getComingSoon() -> Observable<[MovieModel]>
}

class HomeInteractor: HomeUseCase {
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol){
        self.repository = repository
    }
    
    func getBannerList() -> Observable<[MovieModel]> {
        return repository.getBannerList()
    }
    
    func getPopularList() -> Observable<[MovieModel]> {
        return repository.getPopularMovieList()
    }
    
    func getComingSoon() -> Observable<[MovieModel]> {
        return repository.getComingSoonList()
    }
    
    
}
