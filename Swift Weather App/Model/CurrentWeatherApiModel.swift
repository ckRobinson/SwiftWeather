//
//  CurrentWeatherApiModel.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import Foundation

struct WeatherApiDataModel: Codable {
    let coord: Coord;
    let weather: [Weather];
    let main: MainWeather;
    let visibility: Int;
    let wind: WindSpeed;
    let clouds: Clouds;
    let dt: Int;
    let sys: WeatherSystemData;
    let timezone: Int
    let id: Int;
    let name: String;
    
    static let mockData = WeatherApiDataModel(coord: .mockData,
                                       weather: Weather.mockData,
                                       main: .mockData,
                                       visibility: 10000,
                                       wind: .mockData,
                                       clouds: .mockData,
                                       dt: 1687711340,
                                       sys: .mockData,
                                       timezone: -25200,
                                       id: 5322737,
                                       name: "Alameda")
}

struct Coord: Codable {
    let lon: Float;
    let lat: Float;
    
    static let mockData = Coord(lon: -122.2416, lat: 37.7652)
}

struct Weather: Codable {
    let id: Int;
    let main: String;
    let description: String;
    let icon: String
    
    static let mockData = [Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04d")]
}

struct MainWeather: Codable {
    let temp: Float;
    let feels_like: Float;
    let temp_min: Float;
    let temp_max: Float;
    let pressure: Int;
    let humidity: Int;
    
    static let mockData = MainWeather(temp: 287.09, feels_like: 286.73, temp_min: 285.08, temp_max: 290, pressure: 1019, humidity: 84)
}

struct WindSpeed: Codable {
    let speed: Double;
    let deg: Int;
    
    static let mockData = WindSpeed(speed: 5.66, deg: 290)
}

struct Clouds: Codable {
    let all: Int;
    
    static let mockData = Clouds(all: 100)
}

struct WeatherSystemData: Codable {
    let type: Int;
    let id: Int;
    let country: String;
    let sunrise: Int;
    let sunset: Int;
    
    static let mockData = WeatherSystemData(type: 2, id: 2016341, country: "US", sunrise: 1687697300, sunset: 1687750482)
}
