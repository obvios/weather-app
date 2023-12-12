//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/11/23.
//

import Foundation

class WeatherViewModel {

    // This function fetches weather data for a given city
    func fetchWeather(forCity city: String, completion: @escaping (WeatherData?, Error?) -> Void) {
        // Implement the API call here
        // On successful fetch, call completion with WeatherData
        // On failure, call completion with Error
    }

    func saveLastSearchedCity(cityName: String) {
        UserDefaults.standard.set(cityName, forKey: "lastSearchedCity")
    }

    func loadLastSearchedCity() -> String? {
        return UserDefaults.standard.string(forKey: "lastSearchedCity")
    }
}
