//
//  LocationManager+Extensions.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/12/23.
//

import Foundation
import CoreLocation

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            requestLocationPermission()
        case .restricted, .denied:
            stopUpdatingLocation()
        case .authorizedWhenInUse:
            startUpdatingLocation()
        default:
            break
        }
    }
}
