//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/12/23.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject {
    private let locationManager = CLLocationManager()
    let locationPublisher = PassthroughSubject<CLLocation, Never>()
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}
