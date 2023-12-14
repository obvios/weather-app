//
//  WeatherIconsAPI.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/13/23.
//

import Foundation

struct WeatherIconsAPI {
    let apiConfiguration: APIConfiguration = {
        let baseURL = "openweathermap.org"
        return APIConfiguration(apiKey: nil, baseURL: baseURL)
    }()
    
    func requestIconData(iconName: String) async throws -> Data {
        let path = "/img/wn/" + iconName + "@2x.png"
        let endpoint = Endpoint(path: path, method: .GET)
        guard let urlRequest = endpoint.urlRequest(configuration: apiConfiguration), let url = urlRequest.url else {
            throw APIError.unableToBuildRequest
        }
        let networkService = NetworkService()
        return try await networkService.requestData(url)
    }
}
