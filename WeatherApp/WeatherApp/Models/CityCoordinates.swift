//
//  CityCoordinates.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/12/23.
//

import Foundation

struct CityCoordinates: Decodable {
    let lat: Double
    let lon: Double
    let name: String
    let country: String
}
