//
//  ForecastManager.swift
//  Weather to Be
//
//  Created by Nate Howell on 8/20/21.
//

import Foundation
import CoreLocation

protocol ForecastManagerDelegate {
    func didGetToday(_ forecastManager: ForecastManager, forecast: ForecastModelToday)
    func didGetWeek(_ forecastManager: ForecastManager, forecast: ForecastModelWeek)
    func didFailWithError(error: Error)
}

struct ForecastManager {
    
    var delegate: ForecastManagerDelegate?
    func fetchWeatherForForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let apiKey = "b16248af22ebd2db62aaa8f46a1dd421" // The key is left empty intentionally (2 of 2), enter your own API key here or reach out to project owner
        let forecastURL = "https://api.openweathermap.org/data/2.5/onecall?appid=\(apiKey)"
        let urlString = "\(forecastURL)&lat=\(latitude)&lon=\(longitude)"
        performRequestForToday(with: urlString)
        performRequestForWeek(with: urlString)
    }
    
    func performRequestForToday(with urlString: String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let forecast = self.parseJSONToday(safeData) {
                        self.delegate?.didGetToday(self, forecast: forecast)
                    }
                }
            }
            task.resume()
        }
    }
    
    func performRequestForWeek(with urlString: String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let forecast = self.parseJSONWeek(safeData) {
                        self.delegate?.didGetWeek(self, forecast: forecast)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSONToday(_ forecastData: Data) -> ForecastModelToday? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
            let currentTime = decodedData.current.dt
            let temp = decodedData.hourly.temp
            let forecast = ForecastModelToday(time: currentTime, temperature: temp)
            return forecast
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseJSONWeek(_ forecastData: Data) -> ForecastModelWeek? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
            let time = decodedData.current.dt
            let highTemperature = decodedData.daily.temp.max
            let lowTemperature = decodedData.daily.temp.min
            let forecast = ForecastModelWeek(time: time, highTemp: highTemperature, lowTemp: lowTemperature)
            return forecast
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

