//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Eric Palma on 12/11/23.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {
    func testEndpointWithAPIKey() {
        let config = APIConfiguration(apiKey: "testKey", baseURL: "api.openweathermap.org")
        let queryItems: [URLQueryItem] = [.init(name: "param1", value: "value1")]
        let endpoint = Endpoint(path: "/weather/", method: .GET, parameters: queryItems)
        let urlRequest = endpoint.urlRequest(configuration: config)!
        
        XCTAssertEqual(urlRequest.url!.scheme!, "https")
        XCTAssertEqual(urlRequest.url!.absoluteString, "https://api.openweathermap.org/weather/?param1=value1&appid=testKey")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

    func testEndpointWithoutAPIKey() {
        let config = APIConfiguration(apiKey: nil, baseURL: "api.openweathermap.org")
        let endpoint = Endpoint(path: "/img/wn/10d@2x.png", method: .GET)
        let urlRequest = endpoint.urlRequest(configuration: config)!
        
        XCTAssertEqual(urlRequest.url!.scheme!, "https")
        XCTAssertEqual(urlRequest.url!.absoluteString, "https://api.openweathermap.org/img/wn/10d@2x.png")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
}
