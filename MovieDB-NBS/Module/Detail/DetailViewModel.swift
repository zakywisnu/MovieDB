//
//  DetailViewModel.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 20/06/21.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    private let useCase: DetailUseCase
    
    init(useCase: DetailUseCase){
        self.useCase = useCase
    }
    

    var movie = BehaviorRelay<MovieModel>(value: MovieModel(id: 0, title: "", overview: "", posterPath: "", backdropPath: "", voteAverage: 0, releaseDate: "", runtime: 0, genre: [], favorite: false))
    var isLoading = BehaviorRelay<Bool>(value: false)
    var errorMessages = BehaviorRelay<String?>(value: nil)
    var isError = BehaviorRelay<Bool>(value: false)
    
    func getDetailMovie(id: Int){
        isLoading.accept(true)
        useCase.getDetailMovie(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.movie.accept(result)
            } onError: { error in
                self.errorMessages.accept(error.localizedDescription)
                self.isError.accept(true)
                self.isLoading.accept(false)
            } onCompleted: {
                self.isError.accept(false)
                self.isLoading.accept(false)
            }.disposed(by: disposeBag)
    }
    
    func updateFavoriteStatus(id: Int){
        isLoading.accept(true)
        useCase.updateFavoriteStatus(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.movie.accept(result)
            } onError: { error in
                self.errorMessages.accept(error.localizedDescription)
                self.isError.accept(true)
                self.isLoading.accept(false)
            } onCompleted: {
                self.isError.accept(false)
                self.isLoading.accept(false)
            }.disposed(by: disposeBag)
    }
}
