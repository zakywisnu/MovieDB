//
//  DetailInteractor.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 18/06/21.
//

import Foundation
import RxSwift

protocol DetailUseCase{
    func getDetailMovie(id: Int) -> Observable<MovieModel>
}

class DetailInteractor: DetailUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol){
        self.repository = repository
    }
    
    func getDetailMovie(id: Int) -> Observable<MovieModel> {
        return repository.getDetailMovie(id: id)
    }
}
