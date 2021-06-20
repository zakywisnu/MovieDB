//
//  HomeViewModel.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 19/06/21.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    private let homeUseCase: HomeUseCase
    
    init(homeUseCase: HomeUseCase){
        self.homeUseCase = homeUseCase
    }
//    @Published var bannerMovies: [MovieModel] = []
//    @Published var popularMovies: [MovieModel] = []
//    @Published var comingSoonMovies: [MovieModel] = []
//    @Published var errorMessages: String = ""
//    @Published var isLoading: Bool = false
//    @Published var isError: Bool = false
    
    var popularMovies = BehaviorRelay<[MovieModel]>(value: [])
    var bannerMovies = BehaviorRelay<[MovieModel]>(value: [])
    var comingSoonMovies = BehaviorRelay<[MovieModel]>(value: [])
    var isLoading = BehaviorRelay<Bool>(value: false)
    var errorMessages = BehaviorRelay<String?>(value: nil)
    var isError = BehaviorRelay<Bool>(value: false)
    
    func getBannerMovies() {
        isLoading.accept(true)
        homeUseCase.getBannerList()
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.bannerMovies.accept(result)
            } onError: { error in
                self.errorMessages.accept(error.localizedDescription)
                self.isError.accept(true)
                self.isLoading.accept(false)
            } onCompleted: {
                self.isError.accept(false)
                self.isLoading.accept(false)
            }.disposed(by: disposeBag)
    }
    
    func getPopularMovies() {
        isLoading.accept(true)
        homeUseCase.getPopularList()
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.popularMovies.accept(result)
            } onError: { error in
                self.isError.accept(true)
                self.errorMessages.accept(error.localizedDescription)
                self.isLoading.accept(false)
            } onCompleted: {
                self.isError.accept(false)
                self.isLoading.accept(false)
            }.disposed(by: disposeBag)
    }
    
    func getComingSoonMovies() {
        isLoading.accept(true)
        homeUseCase.getComingSoon()
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.comingSoonMovies.accept(result)
                print(result)
            } onError: { error in
                self.isError.accept(true)
                self.isLoading.accept(false)
                self.errorMessages.accept(error.localizedDescription)
            } onCompleted: {
                self.isError.accept(false)
                self.isLoading.accept(false)
            }.disposed(by: disposeBag)
    }
    
}
