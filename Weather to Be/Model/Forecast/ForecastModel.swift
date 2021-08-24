//
//  ForecastModel.swift
//  Weather to Be
//
//  Created by Nate Howell on 8/17/21.
//

import Foundation

struct ForecastModel {
    let currentTime: Int
    let currentTemp: Double
    
    var temperatureString: String {
        return String(format: "%.1f", currentTemp)
    }
}
