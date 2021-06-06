//
//  RestaurantModel.swift
//  LearnRXSwift
//
//  Created by MacBook on 05/06/21.
//

import ObjectMapper

class MovieModel: Mappable {
    var id: Int?
    var title, originalLanguage, originalTitle: String?
    var overview: String?
    var backdropPath, posterPath: String?
    var releaseDate: String?
    var adult, video : Bool?
    var genreIds: [Int]?
    var popularity, voteAverage: Double?
    var voteCount: Int?

    required init?(map: Map){
    }
    
    init(){
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        originalLanguage <- map["original_language"]
        originalTitle <- map["original_title"]
        overview <- map["overview"]
        backdropPath <- map["backdrop_path"]
        posterPath <- map["poster_path"]
        releaseDate <- map["release_date"]
        adult <- map["adult"]
        video <- map["video"]
        genreIds <- map["genre_ids"]
        popularity <- map["popularity"]
        voteAverage <- map["vote_average"]
        voteCount <- map["vote_count"]
    }
}

typealias MoviesResponse = [MovieModel]
