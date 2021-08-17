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
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
//    let hour = Calendar.current.component(.hour, from: Date())
//
//    switch hour {
//        case 1..<10:
//            greetingLabel.text = "Good Morning!"
//        case 10..<4:
//            greetingLabel.text = "Good Afternoon!"
//        default:
//            greetingLabel.text = "Hello there!"
//        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    
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
            self.highLowLabel.text = "H:\(weather.highTemperature) | L: \(weather.lowTemperature)"
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
