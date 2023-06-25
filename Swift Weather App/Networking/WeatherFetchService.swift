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

struct Constants {
    static let apiKey = "db9a10cd3dd4f0934a3d1d9e7fff30f7"
    static let weatherLonLatApi_BaseUrl = "https://api.openweathermap.org/data/2.5/weather?"
    static let weatherGeoLocApi_BaseUrl = "https://api.openweathermap.org/geo/1.0/direct?"
}

class APIManager {
    static let latitude = "lat="
    static let longitude = "&lon="
    static let apiKey = "&appid=\(Constants.apiKey)"
    static let units = "&units=imperial"
    
    static func getLonLatAPIUrl(lat: Float, lon: Float) -> String {
        
        let apiURLString = "\(Constants.weatherLonLatApi_BaseUrl)\(latitude)\(lat)\(longitude)\(lon)\(units)\(apiKey)"
        print(apiURLString);
        return apiURLString
    }
    
    static func getSearchGeoLocationURL(searchText: String) -> String {
        
        let encodedSearchText = "\(searchText),us".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let apiURLString = "\(Constants.weatherGeoLocApi_BaseUrl)q=\(encodedSearchText)&limit=1\(apiKey)"
        print(apiURLString);
        
        return apiURLString;
    }
}

class WeatherFetchService {
    
    public func fetchWeatherBy(search: String) async throws -> WeatherModel {
        
        let locations = try await fetchGeoLocation(search: search);
        if(locations.count == 0) {
            throw APIError.decodingError
        }
        
        return try await fetchWeatherBy(lat: locations[0].lat, lon: locations[0].lon);
    }
    
    public func fetchWeatherBy(lat: Float, lon: Float) async throws -> WeatherModel {
        
        guard let url = URL(string: APIManager.getLonLatAPIUrl(lat: lat, lon: lon)) else {
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

    private func fetchGeoLocation(search: String) async throws -> [GeoLocationDataModel] {
        
        guard let url = URL(string: APIManager.getSearchGeoLocationURL(searchText: search)) else {
            throw APIError.invalidUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url);
        guard let resp = response as? HTTPURLResponse,
              resp.statusCode == 200 else {
            print("Got response status \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
            throw APIError.invalidResponse
        }
//        if let responseStr = String(data: data, encoding: .utf8) {
//            print("Got Geo Location Response: \(responseStr)");
//        }
        return try JSONDecoder().decode([GeoLocationDataModel].self, from: data)
    }
}
