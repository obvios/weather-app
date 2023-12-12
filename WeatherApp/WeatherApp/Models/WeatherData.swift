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
    let id: String?
    let main: String?
    let description: String?
    let icon: String?
}


