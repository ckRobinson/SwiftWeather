//
//  WeatherDataViewModel.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import Foundation

class WeatherDataViewModel: ObservableObject {
    
    @Published var weatherData: WeatherModel?;
    let weatherDataService: WeatherFetchService = WeatherFetchService();
    
    @MainActor func updateWeatherData() {
        
        Task {
            do {
                let weatherData: WeatherModel = try await weatherDataService.fetchWeather()
                self.weatherData = weatherData;
                print(weatherData);
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
