//
//  Endpoint.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/12/23.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let parameters: [URLQueryItem]?
    
    init(path: String, method: HTTPMethod, parameters: [URLQueryItem]? = nil) {
        self.path = path
        self.method = method
        self.parameters = parameters
    }
    
    func urlRequest(configuration: APIConfiguration) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = configuration.scheme
        urlComponents.host = configuration.baseURL
        urlComponents.path = path
        urlComponents.queryItems = parameters
        if let apiKey = configuration.apiKey {
            urlComponents.queryItems?.append(.init(name: "appid", value: apiKey))
        }
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = configuration.headers
        return request
    }
}
