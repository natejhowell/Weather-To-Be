//
//  ForecastModel.swift
//  Weather to Be
//
//  Created by Nate Howell on 8/17/21.
//

import Foundation

struct ForecastModelToday {
    var conditionIdFirst: Int
    var conditionIdSecond: Int
    var conditionIdThird: Int
    var conditionIdFourth: Int
    var conditionIdFifth: Int
    var temperatureFirst: Double
    var temperatureSecond: Double
    var temperatureThird: Double
    var temperatureFourth: Double
    var temperatureFifth: Double
    
    var temperatureStringFirst: String {
        return String(format: "%.1f", temperatureFirst)
    }
    var temperatureStringSecond: String {
        return String(format: "%.1f", temperatureSecond)
    }
    var temperatureStringThird: String {
        return String(format: "%.1f", temperatureThird)
    }
    var temperatureStringFourth: String {
        return String(format: "%.1f", temperatureFourth)
    }
    var temperatureStringFifth: String {
        return String(format: "%.1f", temperatureFifth)
    }
    
    var conditionNameFirst: String {
        switch conditionIdFirst {
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
    
    var conditionNameSecond: String {
        switch conditionIdSecond {
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
    
    var conditionNameThird: String {
        switch conditionIdThird {
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
    
    var conditionNameFourth: String {
        switch conditionIdFourth {
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
    
    var conditionNameFifth: String {
        switch conditionIdFifth {
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
}
    struct ForecastModelWeek {
            var highTempFirst: Double
            var lowTempFirst: Double
            var highTempSecond: Double
            var lowTempSecond: Double
            var highTempThird: Double
            var lowTempThird: Double
            var highTempFourth: Double
            var lowTempFourth: Double
            var highTempFifth: Double
            var lowTempFifth: Double
            
            var highTemperatureStringFirst: String {
                return String(format: "%.1f", highTempFirst)
            }
            var lowTemperatureStringFirst: String {
                return String(format: "%.1f", lowTempFirst)
            }
            
            var highTemperatureStringSecond: String {
                return String(format: "%.1f", highTempSecond)
            }
            var lowTemperatureStringSecond: String {
                return String(format: "%.1f", lowTempSecond)
            }
            
            var highTemperatureStringThird: String {
                return String(format: "%.1f", highTempThird)
            }
            var lowTemperatureStringThird: String {
                return String(format: "%.1f", lowTempThird)
            }
            
            var highTemperatureStringFourth: String {
                return String(format: "%.1f", highTempFourth)
            }
            var lowTemperatureStringFourth: String {
                return String(format: "%.1f", lowTempFourth)
            }
            
            var highTemperatureStringFifth: String {
                return String(format: "%.1f", highTempFifth)
            }
            var lowTemperatureStringFifth: String {
                return String(format: "%.1f", lowTempFifth)
            }
            
        }


