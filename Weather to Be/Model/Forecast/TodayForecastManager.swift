//
//  TodayForecastManager.swift
//  Weather to Be
//
//  Created by Nate Howell on 8/20/21.
//

import Foundation
import CoreLocation

protocol TodayForecastManagerDelegate {
    func didGetToday(_ forecastManager: TodayForecastManager, todaysForecast: ForecastModelToday)
    func didFailWithError(error: Error)
}

struct TodayForecastManager {
    
    var delegate: TodayForecastManagerDelegate?
    func fetchWeatherForTodayForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let apiKey = "b16248af22ebd2db62aaa8f46a1dd421" // The key is left empty intentionally, enter your own API key here or reach out to project owner
        let forecastURL = "https://api.openweathermap.org/data/2.5/onecall?units=imperial&appid=\(apiKey)"
        let urlString = "\(forecastURL)&lat=\(latitude)&lon=\(longitude)"
        performRequestForToday(with: urlString)
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
                    if let todaysforecast = self.parseJSONToday(safeData) {
                        self.delegate?.didGetToday(self, todaysForecast: todaysforecast)
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
                let temp = decodedData.hourly[0].temp
                let todaysForecast = ForecastModelToday(time: currentTime, temperature: temp)
                return todaysForecast
                
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
    }
