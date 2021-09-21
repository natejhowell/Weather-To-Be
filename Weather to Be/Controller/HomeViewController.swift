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
    var todayForecastManager = TodayForecastManager()
    var weekForecastManager = WeekForecastManager()
    let locationManager = CLLocationManager()
    
    var todayForecast = ForecastModelToday(temperatureFirst: 0.0, temperatureSecond: 0.0, temperatureThird: 0.0, temperatureFourth: 0.0, temperatureFifth: 0.0)
    var weekForecast = ForecastModelWeek(highTempFirst: 0.0, lowTempFirst: 0.0, highTempSecond: 0.0, lowTempSecond: 0.0, highTempThird: 0.0, lowTempThird: 0.0, highTempFourth: 0.0, lowTempFourth: 0.0, highTempFifth: 0.0, lowTempFifth: 0.0)
  
    func weekDay(day: Int) -> String {
        switch day {
        case 1, 8:
            return "Sunday"
        case 2, 9:
            return "Monday"
        case 3, 10:
            return "Tuesday"
        case 4, 11:
            return "Wednesday"
        case 5, 12:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "Nada"
        }
    }
    
    func hours(hour: Int) -> String {
        switch hour {
        case 1:
            return "1am"
        case 2:
            return "2am"
        case 3:
            return "3am"
        case 4:
            return "4am"
        case 5:
            return "5am"
        case 6:
            return "6am"
        case 7:
            return "7am"
        case 8:
            return "8am"
        case 9:
            return "9am"
        case 10:
            return "10am"
        case 11:
            return "11am"
        case 12:
            return "12pm"
        case 13:
            return "1pm"
        case 14:
            return "2pm"
        case 15:
            return "3pm"
        case 16:
            return "4pm"
        case 17:
            return "5pm"
        case 18:
            return "6pm"
        case 19:
            return "7pm"
        case 20:
            return "8pm"
        case 21:
            return "9pm"
        case 22:
            return "10pm"
        case 23:
            return "11pm"
        case 24:
            return "12am"
        default:
            return "Nada"
        }
    }
    
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
        todayForecastManager.delegate = self
        weekForecastManager.delegate = self
        
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
    func didGetCurrent(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(weather.temperatureString)°"
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.conditionLabel.text = weather.weatherDiscription
            self.cityLabel.text = weather.cityName
            self.highLowLabel.text = "H: \(weather.highTemperatureString)° | L: \(weather.lowTemperatureString)°"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension HomeViewController: TodayForecastManagerDelegate {

    func didGetToday(_ forecastManager: TodayForecastManager, todaysForecast: ForecastModelToday) {
        DispatchQueue.main.async {
            self.todayForecast = todaysForecast
            self.todayForecast.temperatureFirst = todaysForecast.temperatureFirst
            self.todayForecast.temperatureSecond = todaysForecast.temperatureSecond
            self.todayForecast.temperatureThird = todaysForecast.temperatureThird
            self.todayForecast.temperatureFourth = todaysForecast.temperatureFourth
            self.todayForecast.temperatureFifth = todaysForecast.temperatureFifth
        }
    }
}

extension HomeViewController: WeekForecastManagerDelegate {

    func didGetWeek(_ forecastManager: WeekForecastManager, weeksForecast: ForecastModelWeek) {
        print("show me the money")
        DispatchQueue.main.async {
            self.weekForecast = weeksForecast
            self.weekForecast.highTempFirst = weeksForecast.highTempFirst
            self.weekForecast.lowTempFirst = weeksForecast.lowTempFirst
            self.weekForecast.highTempSecond = weeksForecast.highTempSecond
            self.weekForecast.lowTempSecond = weeksForecast.lowTempSecond
            self.weekForecast.highTempThird = weeksForecast.highTempThird
            self.weekForecast.lowTempThird = weeksForecast.lowTempThird
            self.weekForecast.highTempFourth = weeksForecast.highTempFourth
            self.weekForecast.lowTempFourth = weeksForecast.lowTempFourth
            self.weekForecast.highTempFifth = weeksForecast.highTempFifth
            self.weekForecast.lowTempFifth = weeksForecast.lowTempFifth
        }
        
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
            todayForecastManager.fetchWeatherForTodayForecast(latitude: lat, longitude: lon)
            weekForecastManager.fetchWeatherForWeekForecast(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
//MARK: - HomeViewController Forecast Tableview

extension HomeViewController: UITableViewDelegate, UITableViewDataSource  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell") as! ForecastCell
        let weekday = Calendar.current.component(.weekday, from: Date())
        let time = Calendar.current.component(.hour, from: Date())
        if indexPath.row == 0 {
            let boldText = "Filter:"
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
            let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
            cell.forecastTime.attributedText = attributedString
            cell.forecastTime.text = "Today's Forecast"
            cell.forecastTemp.text = ""
        }
        else if indexPath.row == 1 {
            cell.forecastTime.text = "\(hours(hour: time + 1))"
            cell.forecastTemp.text = "\(todayForecast.temperatureStringFirst)°"
        }
        else if indexPath.row == 2 {
            cell.forecastTime.text = "\(hours(hour: time + 2))"
            cell.forecastTemp.text = "\(todayForecast.temperatureStringSecond)°"
        }
        else if indexPath.row == 3 {
            cell.forecastTime.text = "\(hours(hour: time + 3))"
            cell.forecastTemp.text = "\(todayForecast.temperatureStringThird)°"
        }
        else if indexPath.row == 4 {
            cell.forecastTime.text = "\(hours(hour: time + 4))"
            cell.forecastTemp.text = "\(todayForecast.temperatureStringFourth)°"
        }
        else if indexPath.row == 5 {
            cell.forecastTime.text = "\(hours(hour: time + 5))"
            cell.forecastTemp.text = "\(todayForecast.temperatureStringFifth)°"
        }
        else if indexPath.row == 6 {
            let boldText = "Filter:"
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
            let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
            cell.forecastTime.attributedText = attributedString
            cell.forecastTime.text = "This Week's Forecast"
            cell.forecastTemp.text = ""
        }
        else if indexPath.row == 7 {
            cell.forecastTime.text = "\(weekDay(day: weekday + 1))"
            cell.forecastTemp.text = "H: \(weekForecast.highTemperatureStringFirst)° | L: \(weekForecast.lowTemperatureStringFirst)°"
        }
        else if indexPath.row == 8 {
            cell.forecastTime.text = "\(weekDay(day: weekday + 2))"
            cell.forecastTemp.text = "H: \(weekForecast.highTemperatureStringSecond)° | L: \(weekForecast.lowTemperatureStringSecond)°"
        }
        else if indexPath.row == 9 {
            cell.forecastTime.text = "\(weekDay(day: weekday + 3))"
            cell.forecastTemp.text = "H: \(weekForecast.highTemperatureStringThird)° | L: \(weekForecast.lowTemperatureStringThird)°"
        }
        else if indexPath.row == 10 {
            cell.forecastTime.text = "\(weekDay(day: weekday + 4))"
            cell.forecastTemp.text = "H: \(weekForecast.highTemperatureStringFourth)° | L: \(weekForecast.lowTemperatureStringFourth)°"
        }
        else if indexPath.row == 11 {
            cell.forecastTime.text = "\(weekDay(day: weekday + 5))"
            cell.forecastTemp.text = "H: \(weekForecast.highTemperatureStringFifth)° | L: \(weekForecast.lowTemperatureStringFifth)°"
        }
        else {
            print("oops")
        }
        
        return cell
    }
}
