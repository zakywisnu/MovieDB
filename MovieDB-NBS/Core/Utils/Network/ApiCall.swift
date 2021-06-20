//
//  ApiCall.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 17/06/21.
//

import Foundation

struct MovieConstant {
    static let baseUrl = "https://api.themoviedb.org/"
    static let apiKey = "c3141d1a29379bd03dceb243cd2a5942"
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
}

protocol Endpoint {
    var url: String {get}
}

enum Endpoints{
    enum Gets: Endpoint {
        case popular
        case detailMovie(id: Int)
        
        public var url: String {
            switch self {
            case .popular: return
                "\(MovieConstant.baseUrl)3/discover/movie?api_key=\(MovieConstant.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
            case .detailMovie(let id): return
                "\(MovieConstant.baseUrl)3/movie/\(id)?api_key=\(MovieConstant.apiKey)&language=en-US"
            }
        }
    }
}
