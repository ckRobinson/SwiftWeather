//
//  CurrentWeatherDataModel.swift
//  Swift Weather App
//
//  Created by Cameron on 6/26/23.
//

import Foundation

struct WeatherData {
    let coreData: WeatherApiDataModel
    let time: String;
    var weatherImage: String = "sun.max.fill"
    
    init(originalData: WeatherApiDataModel) {
        self.coreData = originalData;
        
        let date = Date(timeIntervalSince1970: Double(self.coreData.dt))
        let formattedTime = date.formatted(Date.FormatStyle()
            .hour(.defaultDigits(amPM: .abbreviated))
            .minute(.twoDigits))
        self.time = "\(formattedTime)";
    }
}
