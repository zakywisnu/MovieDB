//
//  PopularViewModel.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 20/06/21.
//

import Foundation
import RxSwift

class PopularViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    private let useCase: PopularUseCase
    
    init(useCase: PopularUseCase){
        self.useCase = useCase
    }
    
    @Published var movies: [MovieModel] = []
    @Published var searchMovies: [MovieModel] = []
    @Published var errorMessages: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    func getPopularMovie(){
        isLoading = true
        useCase.getPopularList()
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.movies = result
            } onError: { error in
                self.isError = true
                self.isLoading = false
                self.errorMessages = error.localizedDescription
            } onCompleted: {
                self.isError = false
                self.isLoading = false
            }.disposed(by: disposeBag)
    }
    
    func searchPopularMovies(query: String){
        isLoading = true
        useCase.searchPopular(query: query)
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.searchMovies = result
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
