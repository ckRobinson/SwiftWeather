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

struct LocationStatus {
    
    let temperature: Float;
    var temperatureFormattedString: String {
        String(format: "%.0f", self.temperature)
    }
    
    let dailyHigh: Float;
    var dailyHighFormattedString: String {
        String(format: "%.0f", self.dailyHigh);
    }
    
    let dailyLow: Float;
    var dailyLowFormattedString: String {
        String(format: "%.0f", self.dailyLow);
    }
    
    let description: String;
    let iconPath: String;
    
    init(numericData: NumericWeather_ApiData, descriptiveData: [DescriptveWeather_ApiData]) {
        self.temperature = numericData.temp;
        self.dailyHigh = numericData.temp_max;
        self.dailyLow = numericData.temp_min;
        
        if let data = descriptiveData.first {
            self.description = data.description.capitalized;
            self.iconPath = LocationStatus.getWeatherIconFromApiCode(apiCode: data.icon);
        }
        else {
            self.description = "";
            self.iconPath = "";
        }
    }
    
    private static func getWeatherIconFromApiCode(apiCode: String) -> String {
        return "sun.max.fill" // TODO: Process description to icon type.
    }
    
    public static let mockData = LocationStatus(numericData: NumericWeather_ApiData.mockData, descriptiveData: DescriptveWeather_ApiData.mockData);
}

struct LocationWindConditionsData {
    
    let windSpeedMPH: Int;
    let windDirectionDegrees: Double;
    
    static let mockData = LocationWindConditionsData(windSpeedMPH: 8, windDirectionDegrees: 45.0)
}

struct RainfallData {
    let rainfallInches: Int;
    let rainfallDescription: String;
    
    static let mockData = RainfallData(rainfallInches: 0, rainfallDescription: "None expected in next 10 days.")
}

struct LocationFeelsLikeData {
    let feelsLikeDegrees: Float;
    var feelsLikeFormattedString: String {
        String(format: "%.0f", self.feelsLikeDegrees)
    }
    
    let feelsLikeDescription: String;
    
    init(feelsLikeDegrees: Float, currentTemperatureDregrees: Float) {
        self.feelsLikeDegrees = feelsLikeDegrees
        
        if(Int(self.feelsLikeDegrees) == Int(currentTemperatureDregrees)) {
            self.feelsLikeDescription = "The same as the actual temerature."
        }
        else if(self.feelsLikeDegrees < currentTemperatureDregrees - 5) {
            self.feelsLikeDescription = "Colder than the actual temperature."
        }
        else if(self.feelsLikeDegrees > currentTemperatureDregrees + 5) {
            self.feelsLikeDescription = "Hotter than the actual temperature."
        }
        else {
            self.feelsLikeDescription = "Similar to the actual temperature."
        }
    }
    
    init(feelsLikeDegrees: Float, feelsLikeDescription: String) {
        self.feelsLikeDegrees = feelsLikeDegrees;
        self.feelsLikeDescription = feelsLikeDescription;
    }
    
    static let mockData = LocationFeelsLikeData(feelsLikeDegrees: 71, currentTemperatureDregrees: 71)
}
