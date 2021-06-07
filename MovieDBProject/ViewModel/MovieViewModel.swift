//
//  MovieBannerViewModel.swift
//  MovieDBApp
//
//  Created by MacBook on 06/06/21.
//

import Foundation

class MovieViewModel {
    private let movieModel: MovieModel
    
    var id: Int {
        return movieModel.id ?? 0
    }
    
    var title: String {
        return movieModel.title ?? ""
    }
    
    var overview: String {
        return movieModel.overview ?? ""
    }
    
    var originalTitle: String {
        return movieModel.originalTitle ?? ""
    }
    
    var originalLanguage: String {
        return movieModel.originalLanguage ?? ""
    }
    
    var backdropPath: String {
        return movieModel.backdropPath ?? ""
    }
    
    var posterPath: String {
        return movieModel.posterPath ?? ""
    }
    
    var releaseDate: String {
        return movieModel.releaseDate ?? ""
    }
    
    var year: String {
        return String(movieModel.releaseDate?.prefix(4) ?? "")
    }
    
    init(movieModel: MovieModel){
        self.movieModel = movieModel
    }
}
