//
//  FavoriteInteractor.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 18/06/21.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func getFavoriteMovie() -> Observable<[MovieModel]>
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol){
        self.repository = repository
    }
    
    func getFavoriteMovie() -> Observable<[MovieModel]> {
        return repository.getFavoriteMovie()
    }
    
}
