//
//  RestaurantHttpRouter.swift
//  LearnRXSwift
//
//  Created by MacBook on 05/06/21.
//

import Alamofire

enum MovieHttpRouter {
    case getPopularMovies
    case getUpcomingMovies
    case getPopularMoviesNow
    case getMovieById
}

extension MovieHttpRouter: HttpRouter {
    
    var apiKey: String {
        return "api_key=8ccec078028bd550c96dd69c7af7e74a"
    }
    var language: String {
        return "language=en-US"
    }
    
    var baseUrlString: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var path: String? {
        switch self {
        case .getPopularMovies:
            return "discover/movie?\(apiKey)&\(language)&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
        case .getUpcomingMovies:
            return "discover/movie?\(apiKey)&\(language)&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&year=2022"
        case .getPopularMoviesNow:
            return "discover/movie?\(apiKey)&\(language)&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&year=2021"
        case .getMovieById:
            return "?api_key=7e6dc9e445f1edd16330cb045b7ba4c0&language=en-US"
        }
    }
    
//    var parameters: Parameters? {
//        switch self {
//        case .getBanners:
//            return [
//                "api_key": "",
//                "language": "en-US",
//                "sort_by": "popularity.desc",
//                "include_adult": "false",
//                "include_video": "false",
//                "page": "1"
//            ]
//
//        }
//    }
    
    var method: HTTPMethod {
        switch self {
        case .getPopularMovies:
            return .get
        case .getUpcomingMovies:
            return .get
        case .getPopularMoviesNow:
            return .get
        case .getMovieById:
            return .get
        }
    }
}
