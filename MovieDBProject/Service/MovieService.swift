//
//  RestaurantService.swift
//  LearnRXSwift
//
//  Created by MacBook on 04/06/21.
//

import Foundation
import RxSwift
import Alamofire

class MovieService {
    private lazy var httpService = MovieHttpService()
    static let shared: MovieService = MovieService()
}

extension MovieService: MovieAPI {
    
    func fetchMovieBanners() -> Observable<MoviesResponse> {
        
        return Observable.create { [httpService] (observer) -> Disposable in
                
            do {
                try MovieHttpRouter.getPopularMovies
                    .request(usingHttpService: httpService)
                    .responseJSON { (result) in
                        
                    do {
                        let movies = try MovieService.parseMovies(result: result)
                        observer.onNext(movies)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
                }
            } catch {
                print(error)
                observer.onError(CustomError.error(message: "Movie Banner Fetch Failed"))
            }
            
            return Disposables.create()
        }
    }
    
    func fetchUpcomingMovies() -> Observable<MoviesResponse> {
        
        return Observable.create { [httpService] (observer) -> Disposable in
                
            do {
                try MovieHttpRouter.getUpcomingMovies
                    .request(usingHttpService: httpService)
                    .responseJSON { (result) in
                        
                    do {
                        let movies = try MovieService.parseMovies(result: result)
                        observer.onNext(movies)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
                }
            } catch {
                print(error)
                observer.onError(CustomError.error(message: "Upcoming Movies Fetch Failed"))
            }
            
            return Disposables.create()
        }
    }
    
    func fetchPopularMovies() -> Observable<MoviesResponse> {
        
        return Observable.create { [httpService] (observer) -> Disposable in
                
            do {
                try MovieHttpRouter.getPopularMoviesNow
                    .request(usingHttpService: httpService)
                    .responseJSON { (result) in
                        
                    do {
                        let restaurants = try MovieService.parseMovies(result: result)
                        observer.onNext(restaurants)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
                }
            } catch {
                print(error)
                observer.onError(CustomError.error(message: "Popular Movies Fetch Failed"))
            }
            
            return Disposables.create()
        }
    }
    
    func fetchMovieById(id: Int) -> Observable<MovieModel> {
        
        return Observable.create { [httpService] (observer) -> Disposable in
                
            do {
                try MovieHttpRouter.getMovieById
                    .requestById(usingHttpService: httpService, id: id)
                    .responseJSON { (result) in
                        
                    do {
                        let movie = try MovieService.parseMovie(result: result)
                        observer.onNext(movie)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
                }
            } catch {
                print(error)
                observer.onError(CustomError.error(message: "Popular Movies Fetch Failed"))
            }
            
            return Disposables.create()
        }
    }
}

extension MovieService {
    
    static func parseMovies(result: AFDataResponse<Any>) throws -> MoviesResponse {
        guard
            let data = result.data,
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject]
            else {
                throw CustomError.error(message: "Invalid Parse Movie JSON")
        }
        
        if let jsonData = json["results"] as? [Any] {
            let jsonObject = try JSONSerialization.data(withJSONObject: jsonData, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            if let jsonString = String(data: jsonObject, encoding: String.Encoding.utf8) {
                if let moviesResponse = MoviesResponse(JSONString: jsonString) {
                    return moviesResponse
                }
            }
        }
        
        throw CustomError.error(message: "Invalid Parse Movie JSON")
    }
    
    static func parseMovie(result: AFDataResponse<Any>) throws -> MovieResponse {
        guard
            let data = result.data,
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject]
            else {
                throw CustomError.error(message: "Invalid Parse Movie JSON")
        }
        
        let jsonObject = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        if let jsonString = String(data: jsonObject, encoding: String.Encoding.utf8) {
            if let movieResponse = MovieResponse(JSONString: jsonString) {
                return movieResponse
            }
        }
        
        throw CustomError.error(message: "Invalid Parse Movie JSON")
    }
    
}

//protocol RestaurantServiceProtocol {
//    func fetchRestaurants() -> Observable<[Restaurant]>
//}
//
//class RestaurantService: RestaurantServiceProtocol {
//
//    func fetchRestaurants() -> Observable<[Restaurant]> {
//
//        return Observable.create { observer -> Disposable in
//
//            guard let path = Bundle.main.path(forResource: "restaurant", ofType: "json") else {
//                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
//                return Disposables.create { }
//            }
//
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
//                observer.onNext(restaurants)
//            } catch {
//                observer.onError(error)
//            }
//
//            return Disposables.create { }
//        }
//    }
//
//}
