//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/11/23.
//

import Foundation
import Combine
import CoreLocation

class WeatherViewModel {
    private var locationManager: LocationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    private let uiDataSubject = PassthroughSubject<WeatherScreenUIData, Never>()
    
    var uiDataPublisher: AnyPublisher<WeatherScreenUIData, Never> {
        uiDataSubject.eraseToAnyPublisher()
    }
    
    /// Called by views when they are ready.
    func onViewLoaded() {
        displayCachedCityWeather()
        setupLocationUpdates()
    }
    
    /// Called by view when user enters search criteria
    func onUserCitySearch(cityName: String) {
        Task {
            // save city to cache
            saveLastSearchedCity(cityName: cityName)
            // request weather data
            let weatherData = try await requestWeather(cityName: cityName)
            guard let weather = weatherData.weather.first else {
                return
            }
            // request icon
            let iconName = weather.icon
            let iconData = try await requestIconData(iconName: iconName)
            // build and publish UI data
            let weatherUIData = WeatherScreenUIData(iconData: iconData,
                                                    weather: weather.main,
                                                    weatherDescription: weather.description,
                                                    temperature: weatherData.main.temp,
                                                    feelsLike: weatherData.main.feelsLike,
                                                    minTemperature: weatherData.main.tempMin,
                                                    maxTemperature: weatherData.main.tempMax)
            // publish
            uiDataSubject.send(weatherUIData)
        }
    }
    
    private func displayCachedCityWeather() {
        guard let cityName = loadLastSearchedCity() else {
            return
        }
        onUserCitySearch(cityName: cityName)
    }
    
    private func setupLocationUpdates() {
        locationManager.locationPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] location in
                self?.onUserLocationReceived(location: location)
            }.store(in: &cancellables)
    }
    
    private func onUserLocationReceived(location: CLLocation) {
        Task {
            // get coordinates
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            // request weather data
            let weatherData = try await requestWeather(lat: lat, lon: lon)
            guard let weather = weatherData.weather.first else {
                return
            }
            // request icon
            let iconName = weather.icon
            let iconData = try await requestIconData(iconName: iconName)
            // build and publish UI data
            let weatherUIData = WeatherScreenUIData(iconData: iconData,
                                                    weather: weather.main,
                                                    weatherDescription: weather.description,
                                                    temperature: weatherData.main.temp,
                                                    feelsLike: weatherData.main.feelsLike,
                                                    minTemperature: weatherData.main.tempMin,
                                                    maxTemperature: weatherData.main.tempMax)
            // publish
            uiDataSubject.send(weatherUIData)
        }
    }
    
    private func requestWeather(lat: Double, lon: Double) async throws -> WeatherData {
        let api = WeatherAPI()
        return try await api.requestWeatherData(lat: lat, lon: lon)
    }
    
    // Reverse geocodes city name and uses coordinates to reqeuest weather data
    private func requestWeather(cityName: String) async throws -> WeatherData {
        let api = WeatherAPI()
        let coordinates = try await api.requestGeoCoordinates(cityName: cityName)
        guard let cityCoordinates = coordinates.first else {
            // could create view model specific errors instead or return null
            throw NetworkError.invalidResponse
        }
        return try await api.requestWeatherData(lat: cityCoordinates.lat, lon: cityCoordinates.lon)
    }

    private func saveLastSearchedCity(cityName: String) {
        UserDefaults.standard.set(cityName, forKey: "lastSearchedCity")
    }

    private func loadLastSearchedCity() -> String? {
        return UserDefaults.standard.string(forKey: "lastSearchedCity")
    }
    
    private func requestIconData(iconName: String) async throws -> Data {
        let api = WeatherIconsAPI()
        return try await api.requestIconData(iconName: iconName)
    }
}

/// Data struct used by UI
struct WeatherScreenUIData {
    let iconData: Data
    let weather: String
    let weatherDescription: String
    let temperature: Double
    let feelsLike: Double
    let minTemperature: Double
    let maxTemperature: Double
}
