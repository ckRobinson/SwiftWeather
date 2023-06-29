//
//  CurrentWeatherApiModel.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import Foundation

struct WeatherApiDataModel: Codable {
    let coord: Coord;
    let descriptiveWeatherData: [DescriptveWeather_ApiData];
    let numericWeatherData: NumericWeather_ApiData;
    let visibility: Int;
    let windConditions: WindConditions_ApiData;
    let clouds: Clouds;
    let dateTime: Int;
    let sunRiseAndSet: LocationSunRiseSet_ApiData;
    let timezone: Int
    let name: String;
    
    enum CodingKeys: String, CodingKey {
        case coord
        case descriptiveWeatherData = "weather"
        case numericWeatherData = "main"
        case visibility
        case windConditions = "wind"
        case clouds
        case dateTime = "dt"
        case sunRiseAndSet = "sys"
        case timezone
        case name
    }
    
    static let mockData = WeatherApiDataModel(coord: .mockData,
                                       descriptiveWeatherData: DescriptveWeather_ApiData.mockData,
                                       numericWeatherData: .mockData,
                                       visibility: 10000,
                                       windConditions: .mockData,
                                       clouds: .mockData,
                                       dateTime: 1687711340,
                                       sunRiseAndSet: .mockData,
                                       timezone: -25200,
                                       name: "Alameda")
}

struct Coord: Codable {
    let lon: Float;
    let lat: Float;
    
    static let mockData = Coord(lon: -122.2416, lat: 37.7652)
}

struct DescriptveWeather_ApiData: Codable {
    let id: Int;
    let main: String;
    let description: String;
    let icon: String
    
    static let mockData = [DescriptveWeather_ApiData(id: 804, main: "Clouds", description: "overcast clouds", icon: "04d")]
}

struct NumericWeather_ApiData: Codable {
    let temp: Float;
    let feels_like: Float;
    let temp_min: Float;
    let temp_max: Float;
    let pressure: Int;
    let humidity: Int;
    
    static let mockData = NumericWeather_ApiData(temp: 87.09, feels_like: 86.73, temp_min: 85.08, temp_max: 90, pressure: 1019, humidity: 84)
}

struct WindConditions_ApiData: Codable {
    let speed: Double;
    let deg: Int;
    
    static let mockData = WindConditions_ApiData(speed: 5.66, deg: 290)
}

struct Clouds: Codable {
    let all: Int;
    
    static let mockData = Clouds(all: 100)
}

struct LocationSunRiseSet_ApiData: Codable {
    let country: String;
    let sunrise: Int;
    let sunset: Int;
    static let mockData = LocationSunRiseSet_ApiData(country: "US", sunrise: 1687697300, sunset: 1687750482)
}
