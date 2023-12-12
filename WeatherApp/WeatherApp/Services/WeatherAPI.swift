//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/12/23.
//

import Foundation

struct APIConfiguration {
    let apiKey: String
    let baseURL: String
    let scheme: String = "https"
    
    var headers: [String: String]? {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        
        return headers
    }
    
    init(apiKey: String, baseURL: String) {
        self.apiKey = apiKey
        self.baseURL = baseURL
    }
    
}

struct WeatherAPI {
    enum APIEndpointPath: String {
        case chatCompletions = "/v1/chat/completions"
    }
    
    let endpointPath: APIEndpointPath
    let bodyData: Codable?
    let apiConfiguration: APIConfiguration
    
    func urlRequest() -> URLRequest? {
        let endpoint = endpointFor(endpointPath)
        var urlRequest = endpoint.urlRequest(configuration: apiConfiguration)
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        if let bodyData = bodyData, let data = try? encoder.encode(bodyData) {
            urlRequest?.httpBody = data
        }
        return urlRequest
    }
    
    private func endpointFor(_ path: APIEndpointPath) -> Endpoint {
        switch path {
        case .chatCompletions:
            return Endpoint(path: path.rawValue, method: .POST)
        }
    }
}
