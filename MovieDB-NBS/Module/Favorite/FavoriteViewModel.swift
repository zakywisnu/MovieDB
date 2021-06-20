//
//  FavoriteViewModel.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 20/06/21.
//

import Foundation
import RxSwift
import RxCocoa

class FavoriteViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    private let useCase: FavoriteUseCase
    
    init(useCase: FavoriteUseCase){
        self.useCase = useCase
    }
    
    var movies = BehaviorRelay<[MovieModel]>(value: [])
    var searchMovies = BehaviorRelay<[MovieModel]>(value: [])
    var isLoading = BehaviorRelay<Bool>(value: false)
    var errorMessages = BehaviorRelay<String?>(value: nil)
    var isError = BehaviorRelay<Bool>(value: false)
    
    func getPopularMovie() {
        isLoading.accept(true)
        useCase.getFavoriteMovie()
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.movies.accept(result)
            } onError: { error in
                self.errorMessages.accept(error.localizedDescription)
                self.isError.accept(true)
                self.isLoading.accept(false)
            } onCompleted: {
                self.isError.accept(false)
                self.isLoading.accept(false)
            }.disposed(by: disposeBag)
    }
    
    func searchFavoriteMovies(query: String){
        isLoading.accept(true)
        let movieValue = self.movies.value
        let searchMovie = movieValue.filter{ (movie) -> Bool in
            movie.title.contains(query)
        }
        self.searchMovies.accept(searchMovie)
        self.isLoading.accept(false)
    }
}
