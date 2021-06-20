//
//  PopularInteractor.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 18/06/21.
//

import Foundation
import RxSwift

protocol PopularUseCase{
    func getPopularList() -> Observable<[MovieModel]>
    func searchPopular(query: String) -> Observable<[MovieModel]>
}

class PopularInteractor: PopularUseCase{

    
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol){
        self.repository = repository
    }
    
    func getPopularList() -> Observable<[MovieModel]> {
        return repository.getPopularMovieList()
    }
    
    func searchPopular(query: String) -> Observable<[MovieModel]> {
        return repository.searchPopularMovie(query: query)
    }
    
}
