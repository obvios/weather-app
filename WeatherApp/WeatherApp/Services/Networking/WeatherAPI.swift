//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/12/23.
//

import Foundation

struct WeatherAPI {
    enum APIEndpointPath {
        case weatherByCoordinates(lat: String, lon: String)
        case geocode(cityName: String)
    }
    
    let apiConfiguration: APIConfiguration = {
        // Normally would not hard code api key in code base, did for simplicity
        let apiKey = "d3229cf39d972082dd5db09da0e63165"
        let baseURL = "api.openweathermap.org"
        return APIConfiguration(apiKey: apiKey, baseURL: baseURL)
    }()
    
    /// Request weather data using geo coordinates
    func requestWeatherData(lat: Double, lon: Double) async throws -> WeatherData {
        let latitude = String(lat)
        let longitude = String(lon)
        let endpoint = resolveEndpoint(for: .weatherByCoordinates(lat: latitude, lon: longitude))
        guard let urlRequest = endpoint.urlRequest(configuration: apiConfiguration) else {
            throw APIError.unableToBuildRequest
        }
        let networkService = NetworkService()
        return try await networkService.request(urlRequest)
    }
    
    /// Request geo coordinates using city name
    func requestGeoCoordinates(cityName: String) async throws -> [CityCoordinates] {
        let endpoint = resolveEndpoint(for: .geocode(cityName: cityName))
        guard let urlRequest = endpoint.urlRequest(configuration: apiConfiguration) else {
            throw APIError.unableToBuildRequest
        }
        
        let networkService = NetworkService()
        return try await networkService.request(urlRequest)
    }
    
    private func resolveEndpoint(for path: APIEndpointPath) -> Endpoint {
        switch path {
        case .weatherByCoordinates(let lat, let lon):
            let queryParameters: [URLQueryItem] = [.init(name: "lat", value: lat),
                                                   .init(name: "lon", value: lon)]
            return Endpoint(path: "/data/2.5/weather", method: .GET, parameters: queryParameters)
        case .geocode(let city):
            let queryParameters: [URLQueryItem] = [.init(name: "q", value: city)]
            return Endpoint(path: "/geo/1.0/direct", method: .GET, parameters: queryParameters)
        }
    }
}
