//
//  WeatherData.swift
//  Weather to Be
//
//  Created by Nate Howell on 8/10/21.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let dt: Int
}

struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
