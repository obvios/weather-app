//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/11/23.
//

import Foundation

/*
 Could have used more descriptive names for these
 structs by using CodingKeys
 */
struct WeatherData: Decodable {
    /// contains the weather conditions information
    let weather: [WeatherCondition]
    /// contains the weather measurements
    let main: WeatherMeasurements
    /// name of location
    let name: String
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
