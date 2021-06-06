//
//  PopularMovieListViewModel.swift
//  MovieDBProject
//
//  Created by MacBook on 07/06/21.
//

import Foundation
import RxSwift

final class PopularMovieListViewModel {
    
    private let movieService: MovieService
    
    init(movieService: MovieService){
        self.movieService = movieService
    }
    
    func fetchPopularMovieListViewModel() -> Observable<[MovieViewModel]>? {
        movieService.fetchPopularMovies().map { $0.map {
            MovieViewModel(movieModel: $0) }
        }
    }
}
