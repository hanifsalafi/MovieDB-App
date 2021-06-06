//
//  HttpService.swift
//  LearnRXSwift
//
//  Created by MacBook on 05/06/21.
//

import Alamofire

protocol HttpService {
    var sessionManager: Session { get }
    func request(url: URLRequestConvertible) -> DataRequest
}
