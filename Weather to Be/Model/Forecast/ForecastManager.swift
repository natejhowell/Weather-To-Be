//
//  ForecastManager.swift
//  Weather to Be
//
//  Created by Nate Howell on 8/20/21.
//

import Foundation
import CoreLocation

protocol ForecastManagerDelegate {
    func didUpdateForecast(_ forecastManager: ForecastManager, forecast: ForecastModel)
    func didFailWithError(error: Error)
}

struct ForecastManager {
    
    var delegate: ForecastManagerDelegate?
    
    func fetchWeatherForForecast(cityName: String) {
        let apiKey = "b16248af22ebd2db62aaa8f46a1dd421" // The key is left empty intentionally (1 of 2), enter your own API key here or reach out to project owner
        let forecastURL = "https://api.openweathermap.org/data/2.5/onecall?appid=\(apiKey)"
        let urlString = "\(forecastURL)&q=\(cityName)"
        performRequestForForecast(with: urlString)
    }

    func fetchWeatherForForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let apiKey = "b16248af22ebd2db62aaa8f46a1dd421" // The key is left empty intentionally (2 of 2), enter your own API key here or reach out to project owner
        let forecastURL = "https://api.openweathermap.org/data/2.5/onecall?appid=\(apiKey)"
        let urlString = "\(forecastURL)&lat=\(latitude)&lon=\(longitude)"
        performRequestForForecast(with: urlString)
    }
    
    func performRequestForForecast(with urlString: String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let forecast = self.parseJSON(safeData) {
                        self.delegate?.didUpdateForecast(self, forecast: forecast)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ forecastData: Data) -> ForecastModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
            let currentTime = decodedData.current.dt
            let temp = decodedData.hourly.temp
            let forecast = ForecastModel(currentTime: currentTime, currentTemp: temp)
            return forecast
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

