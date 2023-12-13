//
//  APIConfiguration.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/12/23.
//

import Foundation

enum APIError: Error {
    case unableToBuildRequest
}

struct APIConfiguration {
    let apiKey: String?
    let baseURL: String
    let scheme: String = "https"
    
    var headers: [String: String]? {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        
        return headers
    }
    
    init(apiKey: String?, baseURL: String) {
        self.apiKey = apiKey
        self.baseURL = baseURL
    }
    
}
