//
//  WeatherIconsAPI.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/13/23.
//

import Foundation

struct WeatherIconsAPI {
    let apiConfiguration: APIConfiguration = {
        // Normally would not hard code api key in code base
        let apiKey = "testKey"
        let baseURL = "openweathermap.org"
        return APIConfiguration(apiKey: apiKey, baseURL: baseURL)
    }()
    
    func requestIconData(iconName: String) async throws -> Data {
        let path = "/img/wn/" + iconName + "@1x.png"
        let endpoint = Endpoint(path: path, method: .GET)
        guard let urlRequest = endpoint.urlRequest(configuration: apiConfiguration), let url = urlRequest.url else {
            throw APIError.unableToBuildRequest
        }
        let networkService = NetworkService()
        return try await networkService.requestData(url)
    }
}
