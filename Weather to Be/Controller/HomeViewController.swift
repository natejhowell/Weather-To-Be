//
//  HomeViewController.swift
//  Weather to Be
//
//  Created by Nate Howell on 8/10/21.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var highLowLabel: UILabel!
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    var dailyForecast: [DailyForecast] = [
        DailyForecast(time: "12pm", temp: "80")
    ]
    var weeklyForecast: [WeeklyForecast] = [
        WeeklyForecast(day: "Sunday", highLow: "H: 87 | L: 75")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        
        self.forecastTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        forecastTableView.register(UINib(nibName: "ForecastCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    
        weatherManager.delegate = self

        // Set greeting based on time of day
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
            case 1..<10:
                greetingLabel.text = "Good Morning!"
            case 10..<16:
                greetingLabel.text = "Good Afternoon!"
            case 16..<24:
                greetingLabel.text = "Good Night!"
            default:
                greetingLabel.text = "Hello there!"
            }
    }

}

extension HomeViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.conditionLabel.text = weather.weatherDiscription
            self.cityLabel.text = weather.cityName
            self.highLowLabel.text = "H: \(weather.highTemperature) | L: \(weather.lowTemperature)"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension HomeViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.requestLocation()
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell") as! ForecastCell
        if indexPath.row == 0 {
            cell.forecastTime.text = "Today's Forecast"
            cell.forecastTemp.text = ""
        }
        else if indexPath.row == 1 {
            cell.forecastTime.text = "1pm"
            cell.forecastTemp.text = "82*"
        }
        else if indexPath.row == 2 {
            cell.forecastTime.text = "2pm"
            cell.forecastTemp.text = "84*"
        }
        else if indexPath.row == 3 {
            cell.forecastTime.text = "3pm"
            cell.forecastTemp.text = "86*"
        }
        else if indexPath.row == 4 {
            cell.forecastTime.text = "4pm"
            cell.forecastTemp.text = "86*"
        }
        else if indexPath.row == 5 {
            cell.forecastTime.text = "5pm"
            cell.forecastTemp.text = "84*"
        }
        else if indexPath.row == 6 {
            cell.forecastTime.text = "This Week's Forecast"
            cell.forecastTemp.text = ""
        }
        else if indexPath.row == 7 {
            cell.forecastTime.text = "Sunday"
            cell.forecastTemp.text = "H: 87 | L: 75"
        }
        else if indexPath.row == 8 {
            cell.forecastTime.text = "Monday"
            cell.forecastTemp.text = "H: 89 | L: 77"
        }
        else if indexPath.row == 9 {
            cell.forecastTime.text = "Tuesday"
            cell.forecastTemp.text = "H: 91 | L: 79"
        }
        else if indexPath.row == 10 {
            cell.forecastTime.text = "Wednesday"
            cell.forecastTemp.text = "H: 89 | L: 77"
        }
        else if indexPath.row == 11 {
            cell.forecastTime.text = "Thursday"
            cell.forecastTemp.text = "H: 86 | L: 74"
        }
        else {
            print("oops")
        }
        
        return cell
    }
}
