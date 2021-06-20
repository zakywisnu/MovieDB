//
//  Injection.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 17/06/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject{
    private func provideRepository() -> MovieRepositoryProtocol{
        let realm = try? Realm()
        
        let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return MovieRepository.sharedInstance(local, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail() -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }
    func provideFavorite() -> FavoriteUseCase{
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
    func providePopular() -> PopularUseCase{
        let repository = provideRepository()
        return PopularInteractor(repository: repository)
    }
}
