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
}
