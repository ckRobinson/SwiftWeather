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
        
        self.locationName = rawData.name;
        self.localTime = LocationCurrentWeatherData.formatLocalTime(timeStamp: rawData.dt);
        
        self.currentTemp = rawData.main.temp;
        self.dayMinTemp = rawData.main.temp_min;
        self.dayMaxTemp = rawData.main.temp_max;
        
        if let data = rawData.weather.first {
            self.dayWeatherDescription = data.description.capitalized;
            self.weatherIconName = LocationCurrentWeatherData.getWeatherIconFromApiCode(apiCode: data.icon);
        }
        else {
            self.dayWeatherDescription = "";
            self.weatherIconName = "";
        }
    }
    
    private static func formatLocalTime(timeStamp: Int) -> String {
        
        let date = Date(timeIntervalSince1970: Double(timeStamp))
        let formattedTime = date.formatted(Date.FormatStyle()
            .hour(.defaultDigits(amPM: .abbreviated))
            .minute(.twoDigits))
        return "\(formattedTime)";
    }
    
    private static func getWeatherIconFromApiCode(apiCode: String) -> String {
        return "sun.max.fill" // TODO: Process description to icon type.
    }
    
    public static func mockData() -> LocationCurrentWeatherData {
        return LocationCurrentWeatherData(rawData: WeatherApiDataModel.mockData)
    }
}
