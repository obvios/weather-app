//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/11/23.
//

import Foundation

class WeatherViewModel {

    private func requestWeather(lat: Double, lon: Double) async throws -> WeatherData {
        let api = WeatherAPI()
        return try await api.requestWeatherData(lat: lat, lon: lon)
    }
    
    // Reverse geocodes city name and uses coordinates to reqeuest weather data
    private func requestWeather(cityName: String) async throws -> WeatherData {
        let api = WeatherAPI()
        let coordinates = try await api.requestGeoCoordinates(cityName: cityName)
        guard let cityCoordinates = coordinates.first else {
            // could create view model specific errors instead or return null
            throw NetworkError.invalidResponse
        }
        return try await api.requestWeatherData(lat: cityCoordinates.lat, lon: cityCoordinates.lon)
    }

    private func saveLastSearchedCity(cityName: String) {
        UserDefaults.standard.set(cityName, forKey: "lastSearchedCity")
    }

    private func loadLastSearchedCity() -> String? {
        return UserDefaults.standard.string(forKey: "lastSearchedCity")
    }
    
    private func requestIconData(iconName: String) async throws -> Data {
        let api = WeatherIconsAPI()
        return try await api.requestIconData(iconName: iconName)
    }
}
