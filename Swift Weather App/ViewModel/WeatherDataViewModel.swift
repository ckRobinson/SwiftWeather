//
//  WeatherDataViewModel.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import Foundation


class WeatherDataViewModel: ObservableObject, UserLocationManagerDelegate {
    
    @Published var userLocation: LocationCurrentWeatherData?;
    @Published var timeBasedBackgroundState: BackgroundState = .day;
    let weatherDataService: WeatherFetchService = WeatherFetchService();
    let locationManager: UserLocationManager = UserLocationManager();

    init() {
        self.timeBasedBackgroundState = BackgroundState.parseDateToBackgroundState(date: Date())    
        self.locationManager.delegate = self;
        self.locationManager.requestUsersLocation()
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
    
    @MainActor func updatedUser(lat: Double, lon: Double) {
        self.updateWeatherData(lat: Float(lat), lon: Float(lon));
    }
}
