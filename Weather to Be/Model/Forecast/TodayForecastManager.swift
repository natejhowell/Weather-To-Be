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
                let condIdFirst = decodedData.hourly[0].weather[0].id
                let condIdSecond = decodedData.hourly[1].weather[0].id
                let condIdThird = decodedData.hourly[2].weather[0].id
                let condIdFourth = decodedData.hourly[3].weather[0].id
                let condIdFifth = decodedData.hourly[4].weather[0].id
                let tempFirst = decodedData.hourly[0].temp
                let tempSecond = decodedData.hourly[1].temp
                let tempThird = decodedData.hourly[2].temp
                let tempFourth = decodedData.hourly[3].temp
                let tempFifth = decodedData.hourly[4].temp
                let todaysForecast = ForecastModelToday(conditionIdFirst: condIdFirst, conditionIdSecond: condIdSecond, conditionIdThird: condIdThird, conditionIdFourth: condIdFourth, conditionIdFifth: condIdFifth, temperatureFirst: tempFirst, temperatureSecond: tempSecond, temperatureThird: tempThird, temperatureFourth: tempFourth, temperatureFifth: tempFifth)
                print(decodedData.hourly[0].weather[0].id)
                return todaysForecast
                
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
    }
