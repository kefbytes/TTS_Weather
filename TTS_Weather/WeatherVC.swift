//
//  WeatherVC.swift
//  Swift_Weather
//
//  Created by Franks, Kent on 12/13/17.
//  Copyright © 2017 KefBytes. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    let weatherVM = WeatherVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.isHidden = true
        tempLabel.isHidden = true
        descLabel.isHidden = true
    }

    @IBAction func getWeatherAction(_ sender: Any) {
        weatherVM.fetchWeather(city: cityTextField.text!) {(response) -> Void in
            self.presentWeather()
        }
    }
    
    func presentWeather() {
        DispatchQueue.main.async {
            self.cityLabel.text = self.weatherVM.weather?.name
            guard let tempString = self.weatherVM.weather?.temp else {
                print("❌ problem unwrapping the temperature")
                return
            }
            self.tempLabel.text = "\(String(tempString))º"
            guard let desc = self.weatherVM.weather?.description else {
                return
            }
            switch desc {
                case "clear sky":
                    self.descLabel.text = "☀️"
                case "few clouds":
                    self.descLabel.text = "🌥"
                case "scattered clouds":
                    self.descLabel.text = "🌥"
                case "overcast clouds":
                    self.descLabel.text = "☁️"
                case "snow":
                    self.descLabel.text = "❄️"
                case "light snow":
                    self.descLabel.text = "🌨"
                case "shower rain":
                    self.descLabel.text = "☔️"
                case "scattered showers":
                    self.descLabel.text = "🌧"
                case "broken clouds":
                    self.descLabel.text = "⛅️"
                case "moderate rain":
                    self.descLabel.text = "⛈"
                default:
                    self.descLabel.text = "🌈"
            }
            self.cityLabel.isHidden = false
            self.tempLabel.isHidden = false
            self.descLabel.isHidden = false
       }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
