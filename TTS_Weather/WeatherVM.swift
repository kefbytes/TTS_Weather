//
//  WeatherVM.swift
//  Swift_Weather
//
//  Created by Franks, Kent on 12/13/17.
//  Copyright © 2017 KefBytes. All rights reserved.
//

import Foundation

class WeatherVM {
    
    var weather: Weather?
    
    func fetchWeather(city: String, completionHandler: @escaping (String) -> Void) {
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=b4babdf7c4fc57ccb46e80d1bbf8d6cb")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                do {
                    self.weather = try JSONDecoder().decode(Weather.self, from: data)
                    completionHandler("completed")
                } catch {
                    return
                }
            }
        })
        task.resume()
    }
}











