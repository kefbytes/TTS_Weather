//
//  Weather.swift
//  Swift_Weather
//
//  Created by Franks, Kent on 12/13/17.
//  Copyright © 2017 KefBytes. All rights reserved.
//
import Foundation

class Weather: Decodable {
    
    let name: String
    let temp: Int
    let description: String
    
    required init(from decoder: Decoder) throws {
        //Decoding temp
        enum MainKey: CodingKey {
            case main
        }
        enum TempKey: CodingKey {
            case temp
        }
        let mainRoot = try decoder.container(keyedBy: MainKey.self)
        let main = try mainRoot.nestedContainer(keyedBy: TempKey.self, forKey: .main)
        self.temp = Int((try main.decode(Double.self, forKey: .temp)) * 9/5 - 459.67)
        
        // Decoding name
        enum NameKey: CodingKey {
            case name
        }
        let container = try decoder.container(keyedBy: NameKey.self)
        self.name = try container.decode(String.self, forKey: .name)
        
        //Decoding description
        enum RootKey: CodingKey {
            case weather
        }
        enum DescriptionKey: CodingKey {
            case description
        }
        
        let weatherRoot = try decoder.container(keyedBy: RootKey.self)
        
        if weatherRoot.contains(.weather) {
            var weatherArray = try weatherRoot.nestedUnkeyedContainer(forKey: .weather)
            let firstResult = try weatherArray.nestedContainer(keyedBy: DescriptionKey.self)
            self.description = try firstResult.decode(String.self, forKey: .description)
        } else {
            self.description = ""
        }
    }
    
}
