//
//  WeekForecastManager.swift
//  Weather to Be
//
//  Created by Nate Howell on 8/27/21.
//

import Foundation
import CoreLocation

protocol WeekForecastManagerDelegate {
    func didGetWeek(_ forecastManager: WeekForecastManager, weeksForecast: ForecastModelWeek)
    func didFailWithError(error: Error)
}

struct WeekForecastManager {
        
        var delegate: WeekForecastManagerDelegate?
        func fetchWeatherForWeekForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
            let apiKey = "b16248af22ebd2db62aaa8f46a1dd421" // The key is left empty intentionally, enter your own API key here or reach out to project owner
            let forecastURL = "https://api.openweathermap.org/data/2.5/onecall?units=imperial&appid=\(apiKey)"
            let urlString = "\(forecastURL)&lat=\(latitude)&lon=\(longitude)"
            performRequestForWeek(with: urlString)
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
                        if let weeksforecast = self.parseJSONWeek(safeData) {
                            self.delegate?.didGetWeek(self, weeksForecast: weeksforecast)
                        }
                    }
                }
                task.resume()
            }
        }
        
        func parseJSONWeek(_ forecastData: Data) -> ForecastModelWeek? {
            let decoder = JSONDecoder()
            print("DATA: ", forecastData)
            do {
                let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
                let time = decodedData.current.dt
                let highTemperature = decodedData.daily[1].temp.max
                let lowTemperature = decodedData.daily[1].temp.min
                let weeksForecast = ForecastModelWeek(time: time, highTemp: highTemperature, lowTemp: lowTemperature)
                return weeksForecast
                
            } catch {
                print("ERROR: ", error)
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
        
}

