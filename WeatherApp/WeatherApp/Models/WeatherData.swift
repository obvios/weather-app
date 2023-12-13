//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/11/23.
//

import Foundation

struct WeatherData: Decodable {
    let weather: [WeatherCondition]
    let main: WeatherMeasurements
}

struct WeatherCondition: Decodable {
    let id: Int
    /// main weather type (ie: Rain, Sunny)
    let main: String
    /// additional description of main weather
    let description: String
    /// name of icon to use to represent weather
    let icon: String
}

struct WeatherMeasurements: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
}
