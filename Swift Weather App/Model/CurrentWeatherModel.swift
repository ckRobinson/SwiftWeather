//
//  CurrentWeatherModel.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import Foundation

struct WeatherModel: Codable {
    let coord: Coord;
    let weather: Weather;
    let main: MainWeather;
    let visibility: Int;
    let windSpeed: WindSpeed;
    let clouds: Clouds;
    let dt: Int;
    let sys: WeatherSystemData;
    let timezone: Int
    let id: Int;
    let name: String;
    let cod: Int;
}

struct Coord: Codable {
    let lon: Float;
    let lat: Float;
}

struct Weather: Codable {
    let coreWeather: CoreWeather
    let base: String
    
    enum CodingKeys: String, CodingKey {
        case coreWeather = "0"
        case base
    }
}
struct CoreWeather: Codable {
    let id: Int;
    let main: String;
    let description: String;
    let icon: String
}

struct MainWeather: Codable {
    let temp: Float;
    let feels_like: Float;
    let temp_min: Float;
    let temp_max: Float;
    let pressure: Int;
    let humidity: Int;
}

struct WindSpeed: Codable {
    let speed: Float;
    let deg: Float;
}

struct Clouds: Codable {
    let all: Int;
}

struct WeatherSystemData: Codable {
    let type: Int;
    let id: Int;
    let country: String;
    let sunrise: Int;
    let sunset: Int;
}
