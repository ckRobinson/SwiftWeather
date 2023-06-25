//
//  WeatherFetchService.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import Foundation

enum APIError: Error {
    case invalidUrl
    case invalidResponse
    case emptyData
    case serviceUnavailable
    case decodingError
    
    var description: String {
        switch self {
        case .invalidUrl:
            return "invalid url"
        case .invalidResponse:
            return "invalid response"
        case .emptyData:
            return "empty data"
        case .serviceUnavailable:
            return "service unavailable"
        case .decodingError:
            return "decoding error"
        }
    }
}

class WeatherFetchService {
    
    struct Constants {
        static let weatherApiUrl = "https://api.openweathermap.org/data/2.5/weather?"
        static let latitude = "lat="
        static let longitude = "&lon="
        static let apiKey = "&appid=db9a10cd3dd4f0934a3d1d9e7fff30f7"
        static let units = "&units=imperial"
        
        static func getURL(lat: Float, lon: Float) -> String {
            
            return "\(weatherApiUrl)\(latitude)\(lat)\(longitude)\(lon)\(units)\(apiKey)"
        }
    }
    
    public func fetchWeather(lat: Float, lon: Float) async throws -> WeatherModel {
        
        guard let url = URL(string: Constants.getURL(lat: lat, lon: lon)) else {
            throw APIError.invalidUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url);
        guard let resp = response as? HTTPURLResponse,
              resp.statusCode == 200 else {
            print("Got response status \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
            throw APIError.invalidResponse
        }
//        if let responseStr = String(data: data, encoding: .utf8) {
//            print(responseStr)
//        }
        return try JSONDecoder().decode(WeatherModel.self, from: data)
    }
}
