//
//  ForecastData.swift
//  Weather to Be
//
//  Created by Nate Howell on 8/20/21.
//

import Foundation

struct ForecastData: Codable {
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

struct Current: Codable {
    let dt: Int
}

struct Hourly: Codable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
    
    struct Weather: Codable {
        let id: Int
    }
}

struct Daily: Codable {
    let dt: Int
    let temp: Temp
    
    struct Temp: Codable {
        let min: Double
        let max: Double
    }
}

