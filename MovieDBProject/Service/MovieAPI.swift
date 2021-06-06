//
//  RestaurantAPI.swift
//  LearnRXSwift
//
//  Created by MacBook on 05/06/21.
//

import RxSwift

protocol MovieAPI {
    func fetchMovieBanners() -> Observable<MoviesResponse>
}
