//
//  WeatherManager.swift
//  Weather to Be
//
//  Created by Nate Howell on 8/10/21.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didGetCurrent(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let apiKey = "b16248af22ebd2db62aaa8f46a1dd421" // The key is left empty intentionally, enter your own API key here or reach out to project owner
        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=imperial&appid=\(apiKey)"
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didGetCurrent(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let description = decodedData.weather[0].description
            let temp = decodedData.main.temp
            let name = decodedData.name
            let high = decodedData.main.temp_max
            let low = decodedData.main.temp_min
            
            let weather = WeatherModel(conditionId: id, cityName: name, weatherDiscription: description, temperature: temp, highTemperature: high, lowTemperature: low)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
