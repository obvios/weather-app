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
    enum APIEndpointPath {
        case weatherByCoordinates(lat: String, lon: String)
    }
    
    let apiConfiguration: APIConfiguration = {
        // Normally would not hard code api key in code base
        let apiKey = "testKey"
        let baseURL = "api.openweathermap.org"
        return APIConfiguration(apiKey: apiKey, baseURL: baseURL)
    }()
    
    private func urlRequest(endpointPath: APIEndpointPath) -> URLRequest? {
        let endpoint = resolveEndpoint(for: endpointPath)
        var urlRequest = endpoint.urlRequest(configuration: apiConfiguration)
        return urlRequest
    }
    
    private func resolveEndpoint(for path: APIEndpointPath) -> Endpoint {
        switch path {
        case .weatherByCoordinates(let lat, let lon):
            let queryParameters: [URLQueryItem] = [.init(name: "lat", value: lat),
                                                   .init(name: "lon", value: lon)]
            return Endpoint(path: "/data/2.5/weather", method: .GET, parameters: queryParameters)
        }
    }
}
