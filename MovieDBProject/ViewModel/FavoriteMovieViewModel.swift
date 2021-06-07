//
//  MovieFavoriteListViewModel.swift
//  MovieDBProject
//
//  Created by MacBook on 07/06/21.
//

import Foundation
import RxSwift

final class FavoriteMovieViewModel {
    
    private let movieService: MovieService
    
    init(movieService: MovieService){
        self.movieService = movieService
    }
    
    func fetchMovieById(id: Int) -> Observable<MovieResponse>? {
        return movieService.fetchMovieById(id: id)
    }
}
