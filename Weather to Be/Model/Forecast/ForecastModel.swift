//
//  ForecastModel.swift
//  Weather to Be
//
//  Created by Nate Howell on 8/17/21.
//

import Foundation

struct ForecastModelToday {
    var time: Int
    var temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
}

struct ForecastModelWeek {
    var time: Int
    var highTemp: Double
    var lowTemp: Double
    
    var highTemperatureString: String {
        return String(format: "%.1f", highTemp)
    }
        
    var lowTemperatureString: String {
        return String(format: "%.1f", lowTemp)
    }
}
