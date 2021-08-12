//
//  WeatherModel.swift
//  Weather to Be
//
//  Created by Nate Howell on 8/10/21.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let weatherDiscription: String
    let temperature: Double
    let highTemperature: Double
    let lowTemperature: Double
    let greetingId: Int
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
        }
    }
    
    var greeting: String {
        switch greetingId {
        case 1628804669:
            return "Good Afternoon!"
        case 1628804670:
            return "Good Evening!"
        default:
            return "Hello there!"
        }
    }

}
