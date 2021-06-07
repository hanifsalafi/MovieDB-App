//
//  HttpRouter.swift
//  LearnRXSwift
//
//  Created by MacBook on 05/06/21.
//

import Foundation
import Alamofire

protocol HttpRouter {
    var apiKey: String { get }
    var language: String { get }
    
    var baseUrlString: String { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    
    func body() throws -> Data?
    
    func request(usingHttpService service: HttpService) throws -> DataRequest
    func requestById(usingHttpService service: HttpService, id: Int) throws -> DataRequest
}


extension HttpRouter {
    var headers: HTTPHeaders? { return nil }
    var parameters: Parameters? { return nil }
    func body() throws -> Data? { return nil }
    
    func asUrlRequest(_ id: Int?) throws -> URLRequest {
        var urlString = baseUrlString
        if id != nil {
            urlString += "movie/" + "\(id!)" + path!
        } else {
            urlString += path ?? ""
        }
        let url = try urlString.asURL()
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        request.httpBody = try body()
        
        return request
    }
    
    func request(usingHttpService service: HttpService) throws -> DataRequest {
        return try service.request(url: asUrlRequest(nil))
    }
    
    func requestById(usingHttpService service: HttpService, id: Int) throws -> DataRequest {
        return try service.request(url: asUrlRequest(id))
    }
}
