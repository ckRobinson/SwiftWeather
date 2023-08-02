//
//  WeatherDataViewModel.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import Foundation

enum WeatherDataViewState {
    case initial
    case searching
    case loadingGPS
    case loaded
    case apiError
    case locationError
}

class WeatherDataViewModel: ObservableObject, UserLocationManagerDelegate {
    
    @Published var userLocation: LocationCurrentWeatherData?;
    @Published var timeBasedBackgroundState: TimeOfDay = .day;
    @Published var state: WeatherDataViewState = .initial;
    
    let weatherDataService: WeatherFetchService = WeatherFetchService();
    let locationManager: UserLocationManager = UserLocationManager();

    var savedLon: Float = 0;
    var savedLat: Float = 0;
    
    init() {
        self.timeBasedBackgroundState = TimeOfDay.parseDateToBackgroundState(date: Date())
        self.locationManager.delegate = self;
        
        self.updateUserDefaults();
    }

    @MainActor func fetchWeatherBy(search: String) {
        self.state = .searching
        Task {
            do {
                let weatherDataModel: WeatherApiDataModel = try await weatherDataService.fetchWeatherBy(search: search)
                self.saveUserLocation(lat: weatherDataModel.coord.lat, lon: weatherDataModel.coord.lon);
                
                self.userLocation = LocationCurrentWeatherData(rawData: weatherDataModel);
                self.setTimeOfDay();
                self.state = .loaded
            }
            catch {
                if let error = error as? APIError {
                    print(error.description);
                }
                else {
                    print(error.localizedDescription)
                }
                self.state = .apiError
            }
        }
    }

    @MainActor private func updateWeatherData(lat: Float, lon: Float) {
        
        Task {
            do {
                let weatherDataModel: WeatherApiDataModel = try await weatherDataService.fetchWeatherBy(lat: lat, lon: lon)
                self.userLocation = LocationCurrentWeatherData(rawData: weatherDataModel);
                self.setTimeOfDay()
                self.state = .loaded
            }
            catch {
                if let error = error as? APIError {
                    print(error.description);
                }
                else {
                    print(error.localizedDescription)
                }
                self.state = .locationError
            }
        }
    }
    
    private func setTimeOfDay() {
        if let timeOfDay = self.userLocation?.locationInfo.locationTimeOfDay {
            self.timeBasedBackgroundState = timeOfDay;
        }
    }
    
    @MainActor func viewHasAppeared() {
        
        self.state = .searching
        
        if(ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1") {
            Task {
                await self.setDebugGPS()
            }
        }
        
        if self.savedLat == 0 && self.savedLon == 0 {
            self.locationManager.requestUsersLocation()
        }
        else {
            self.updateWeatherData(lat: Float(self.savedLat), lon: Float(self.savedLon));
        }
    }
    
    private func setDebugGPS() async {
        
        sleep(1)
        /// Load "GPS" mock data in preview.
        /// https://stackoverflow.com/questions/58759987/how-do-you-check-if-swiftui-is-in-preview-mode
        self.userLocation = LocationCurrentWeatherData.mockData()
        self.state = .loaded
        return;
    }
    
    @MainActor func updateUserLocation() {
        
        self.clearUserLocation()
        self.state = .loadingGPS
        
        if(ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1") {
            Task {
                await self.setDebugGPS()
            }
        }
        
        self.clearUserLocation()
        self.locationManager.requestUsersLocation()
    }
    
    // MARK: - Location Manager Delegate functions
    @MainActor func updatedUser(lat: Double, lon: Double) {
        
        self.updateWeatherData(lat: Float(lat), lon: Float(lon));
    }
    
    func errorGettingLocation() {
        self.state = .locationError
    }
    
    // MARK: - User Default functions
    /// User defaults tutorial:
    /// https://www.hackingwithswift.com/example-code/system/how-to-save-user-settings-using-userdefaults
    private func updateUserDefaults() {
        let lat = UserDefaults.standard.float(forKey: Constants.userDefaults_SavedLatitude);
        let lon = UserDefaults.standard.float(forKey: Constants.userDefaults_SavedLongitude);
        
        self.savedLat = lat;
        self.savedLon = lon;
    }
    
    private func saveUserLocation(lat: Float, lon: Float) {
        UserDefaults.standard.set(lat, forKey: Constants.userDefaults_SavedLatitude);
        UserDefaults.standard.set(lon, forKey: Constants.userDefaults_SavedLongitude);
    }
    
    private func clearUserLocation() {
        UserDefaults.standard.removeObject(forKey: Constants.userDefaults_SavedLatitude);
        UserDefaults.standard.removeObject(forKey: Constants.userDefaults_SavedLongitude)
    }
}

private struct Constants {
    static let userDefaults_SavedLatitude = "UserSavedLat"
    static let userDefaults_SavedLongitude = "UserSavedLon"
}
