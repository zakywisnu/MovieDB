//
//  DetailViewModel.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 20/06/21.
//

import Foundation
import RxSwift

class DetailViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    private let useCase: DetailUseCase
    
    init(useCase: DetailUseCase){
        self.useCase = useCase
    }
    
    @Published var movie: MovieModel = MovieModel(id: 0, title: "", overview: "", posterPath: "", backdropPath: "", voteAverage: 0, releaseDate: "", runtime: 0, genre: [], favorite: false)
    @Published var errorMessages: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    func getDetailMovie(id: Int){
        isLoading = true
        useCase.getDetailMovie(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.movie = result
            } onError: { error in
                self.isError = true
                self.isLoading = false
                self.errorMessages = error.localizedDescription
            } onCompleted: {
                self.isError = false
                self.isLoading = false
            }.disposed(by: disposeBag)
    }
}
