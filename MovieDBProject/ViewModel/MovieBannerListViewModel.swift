//
//  MovieBannerListViewModel.swift
//  MovieDBApp
//
//  Created by MacBook on 06/06/21.
//

import Foundation
import RxSwift

final class MovieBannerListViewModel {
    
    private let movieService: MovieService
    
    init(movieService: MovieService){
        self.movieService = movieService
    }
    
    func fetchMovieBannerListViewModel() -> Observable<[MovieViewModel]>? {
        movieService.fetchMovieBanners().map { $0.map {
            MovieViewModel(movieModel: $0) }
        }
    }
    
    func fetchUpcomingMovieListViewModel() -> Observable<[MovieViewModel]>? {
        movieService.fetchUpcomingMovies().map { $0.map {
            MovieViewModel(movieModel: $0) }
        }
    }
}
