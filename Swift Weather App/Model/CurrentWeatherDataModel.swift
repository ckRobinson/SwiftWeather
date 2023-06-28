//
//  CurrentWeatherDataModel.swift
//  Swift Weather App
//
//  Created by Cameron on 6/26/23.
//

import Foundation

struct LocationCurrentWeatherData {
    private let rawData: WeatherApiDataModel
    
    let locationName: String;
    let localTime: String;
    
    let currentTemp: Float;
    let dayMinTemp: Float;
    let dayMaxTemp: Float;
    
    let weatherIconName: String;
    let dayWeatherDescription: String;
    
    init(rawData: WeatherApiDataModel) {
        
        self.rawData = rawData;
        
    }
}

struct LocationInfo {
    let name: String;
    let localTime: String;
    
    init(locationName: String, localTimeStamp: Int) {
        
        self.name = locationName;
        self.localTime = LocationInfo.formatLocalTime(localTimeStamp: localTimeStamp);
    }
    
    private static func formatLocalTime(localTimeStamp: Int) -> String {
        
        let date = Date(timeIntervalSince1970: Double(localTimeStamp))
        let formattedTime = date.formatted(Date.FormatStyle()
            .hour(.defaultDigits(amPM: .abbreviated))
            .minute(.twoDigits));
        
        return "\(formattedTime)";
    }
    
    public static let mockData = LocationInfo(locationName: "Cupertino", localTimeStamp: 1687711340)
}
