//
//  UserDefaults+Extensions.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/14/23.
//

import Foundation

enum UserDefaultsKey: String {
    case lastSearchedCity = "lastSearchedCity"
}

extension UserDefaults {
    func stringValue(for key: UserDefaultsKey) -> String? {
        return string(forKey: key.rawValue)
    }
    
    func setStringValue(for key: UserDefaultsKey, to value: String) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
}
