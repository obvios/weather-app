//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/12/23.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case networkError
    case invalidURLRequest
}

class NetworkService {
    private let session: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        session = URLSession(configuration: configuration)
    }
    
    /// Send `URL` and return decoded response
    func request<T: Decodable>(_ url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        let decoder = JSONDecoder()
        let object = try decoder.decode(T.self, from: data)
        return object
    }
    
    /// Send `URLRequest` and return decoded response
    func request<U: Decodable>(_ urlRequest: URLRequest) async throws -> U {
        let (data, response) = try await session.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            print("NetworkService: status code - \(httpResponse.statusCode)")
            throw NetworkError.networkError
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let object = try decoder.decode(U.self, from: data)
        return object
    }
}
