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
    private let locationSubject = PassthroughSubject<CLLocation, Never>()
    private var lastUsedLocationTimestamp: Date?
    
    var locationPublisher: AnyPublisher<CLLocation, Never> {
        locationSubject.eraseToAnyPublisher()
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    private func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    private func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // only interested in latest location
        guard let location = locations.last else {
            return
        }
        
        // only want updates that are more than 1 minute apart. Did this so location updates don't
        // override user city search constantly and too frequently.
        if let lastDate = lastUsedLocationTimestamp, location.timestamp.timeIntervalSince(lastDate) < 60 {
            return
        }
        
        lastUsedLocationTimestamp = location.timestamp
        locationSubject.send(location)
    }
}
