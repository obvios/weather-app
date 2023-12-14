//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Eric Palma on 12/11/23.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {
    func testWeatherEndpoint() {
        let config = APIConfiguration(apiKey: "testKey", baseURL: "api.openweathermap.org")
        let queryItems: [URLQueryItem] = [.init(name: "param1", value: "value1")]
        let urlRequest = Endpoint(path: "/weather/", method: .GET, parameters: queryItems).urlRequest(configuration: config)!
        
        XCTAssertEqual(urlRequest.url!.scheme!, "https")
        XCTAssertEqual(urlRequest.url!.absoluteString, "https://api.openweathermap.org/weather/?param1=value1&appid=testKey")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

}
