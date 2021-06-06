//
//  RestaurantHttpService.swift
//  LearnRXSwift
//
//  Created by MacBook on 05/06/21.
//

import Alamofire

class MovieHttpService: HttpService {
    var sessionManager: Session = Session.default
    func request(url: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(url)
    }
}
