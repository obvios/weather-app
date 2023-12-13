//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/12/23.
//

import Foundation
import CoreLocation
import Combine

class LocationManager {
    private let locationManager = CLLocationManager()
    let locationPublisher = PassthroughSubject<CLLocation, Never>()
    
    
}
