//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/11/23.
//

import Foundation

struct WeatherData: Decodable {
    
}

struct WeatherCondition: Decodable {
    let id: Int
    let main: String
    let description: String
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
