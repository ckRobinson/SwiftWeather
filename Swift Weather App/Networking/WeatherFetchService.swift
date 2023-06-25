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
        static let latitude = "lat=37.7652"
        static let longitude = "&lon=-122.2416"
        static let apiKey = "&appid=db9a10cd3dd4f0934a3d1d9e7fff30f7"
        
        static func getURL() -> String {
            
            return "\(weatherApiUrl)\(latitude)\(longitude)\(apiKey)"
        }
    }
    
    public func fetchWeather() async throws -> WeatherModel {
        
        guard let url = URL(string: Constants.getURL()) else {
            throw APIError.invalidUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url);
        guard let resp = response as? HTTPURLResponse,
              resp.statusCode == 200 else {
            print("Got response status \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
            throw APIError.invalidResponse
        }
        return try JSONDecoder().decode(WeatherModel.self, from: data)
    }
}
