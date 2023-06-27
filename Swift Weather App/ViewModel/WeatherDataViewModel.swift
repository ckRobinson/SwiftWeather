//
//  WeatherDataViewModel.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import Foundation


class WeatherDataViewModel: ObservableObject {
    
    @Published var weatherData: WeatherData?;
    @Published var time: String = "";
    
    let weatherDataService: WeatherFetchService = WeatherFetchService();

    @MainActor func fetchWeatherBy(search: String) {
        Task {
            do {
                let weatherDataModel: WeatherApiDataModel = try await weatherDataService.fetchWeatherBy(search: search)
                self.weatherData = WeatherData(originalData: weatherDataModel);
            }
            catch {
                if let error = error as? APIError {
                    print(error.description);
                }
                else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    /// Will be used to pass in device location. When that is implemented.
    @MainActor func updateWeatherData() {
        
        Task {
            do {
                let weatherDataModel: WeatherApiDataModel = try await weatherDataService.fetchWeatherBy(lat: 37.7652, lon: -122.2416)
                self.weatherData = WeatherData(originalData: weatherDataModel);
            }
            catch {
                if let error = error as? APIError {
                    print(error.description);
                }
                else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @MainActor func updateWeatherData(lat: Float, lon: Float) {
        
        Task {
            do {
                let weatherDataModel: WeatherApiDataModel = try await weatherDataService.fetchWeatherBy(lat: lat, lon: lon)
                self.weatherData = WeatherData(originalData: weatherDataModel);
            }
            catch {
                if let error = error as? APIError {
                    print(error.description);
                }
                else {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
