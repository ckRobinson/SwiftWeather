//
//  WeatherDataViewModel.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import Foundation


class WeatherDataViewModel: ObservableObject {
    
    @Published var userLocation: LocationCurrentWeatherData?;
    @Published var timeBasedBackgroundState: BackgroundState = .day;
    let weatherDataService: WeatherFetchService = WeatherFetchService();
    
    init() {
        self.timeBasedBackgroundState = BackgroundState.parseDateToBackgroundState(date: Date())
    }

    @MainActor func fetchWeatherBy(search: String) {
        Task {
            do {
                let weatherDataModel: WeatherApiDataModel = try await weatherDataService.fetchWeatherBy(search: search)
                self.userLocation = LocationCurrentWeatherData(rawData: weatherDataModel);
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
                self.userLocation = LocationCurrentWeatherData(rawData: weatherDataModel);
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
                self.userLocation = LocationCurrentWeatherData(rawData: weatherDataModel);
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
