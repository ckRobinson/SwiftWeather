//
//  CurrentWeatherDataModel.swift
//  Swift Weather App
//
//  Created by Cameron on 6/26/23.
//

import Foundation

struct LocationCurrentWeatherData {
    private let rawData: WeatherApiDataModel
  
    let locationInfo: LocationInfo;
    let locationStatus: LocationStatus
    
    /// Additional Data:
    let windData: LocationWindConditionsData
    let feelsLike: LocationFeelsLikeData;
    let humidity: LocationHumidityData;
    let visibility: LocationVisibilityData;
    let airPressure: LocationAirPressureData;
    
    init(rawData: WeatherApiDataModel) {
        
        self.rawData = rawData;
        
        self.locationInfo = LocationInfo(locationName: rawData.name, localTimeStamp: rawData.dateTime)
        self.locationStatus = LocationStatus(numericData: rawData.numericWeatherData,
                                                           descriptiveData: rawData.descriptiveWeatherData)
        
        self.windData = LocationWindConditionsData(windSpeedMPH: Int(rawData.windConditions.speed),
                                           windDirectionDegrees: Double(rawData.windConditions.deg));
        self.feelsLike = LocationFeelsLikeData(feelsLikeDegrees: rawData.numericWeatherData.feels_like,
                                                  currentTemperatureDregrees: rawData.numericWeatherData.temp);
        
        self.humidity = LocationHumidityData(humidityPercent: rawData.numericWeatherData.humidity,
                                     currentTempFahrenheit: rawData.numericWeatherData.temp);
        
        self.visibility = LocationVisibilityData(visibilityMeters: rawData.visibility)
        
        self.airPressure = LocationAirPressureData(airPressureIn_hPa: rawData.numericWeatherData.pressure,
                                           airPressureChange: .neutral);
    }
    
    public static func mockData() -> LocationCurrentWeatherData {
        return LocationCurrentWeatherData(rawData: WeatherApiDataModel.mockData)
    }
}

struct LocationInfo {
    let name: String;
    let localTime: String;
    
    init(locationName: String, localTimeStamp: Int) {
        
        self.name = locationName;
        self.localTime = LocationInfo.formatLocalTime(localTimeStamp: localTimeStamp);
    }
    
    private static func formatLocalTime(localTimeStamp: Int) -> String {
        
        let date = Date(timeIntervalSince1970: Double(localTimeStamp))
        let formattedTime = date.formatted(Date.FormatStyle()
            .hour(.defaultDigits(amPM: .abbreviated))
            .minute(.twoDigits));
        
        return "\(formattedTime)";
    }
    
    public static let mockData = LocationInfo(locationName: "Cupertino", localTimeStamp: 1687711340)
}

struct LocationStatus {
    
    let temperature: Float;
    var temperatureFormattedString: String {
        String(format: "%.0f", self.temperature)
    }
    
    let dailyHigh: Float;
    var dailyHighFormattedString: String {
        String(format: "%.0f", self.dailyHigh);
    }
    
    let dailyLow: Float;
    var dailyLowFormattedString: String {
        String(format: "%.0f", self.dailyLow);
    }
    
    let description: String;
    let iconPath: String;
    
    init(numericData: NumericWeather_ApiData, descriptiveData: [DescriptveWeather_ApiData]) {
        self.temperature = numericData.temp;
        self.dailyHigh = numericData.temp_max;
        self.dailyLow = numericData.temp_min;
        
        if let data = descriptiveData.first {
            self.description = data.description.capitalized;
            self.iconPath = LocationStatus.getWeatherIconFromApiCode(apiCode: data.icon);
        }
        else {
            self.description = "";
            self.iconPath = "";
        }
    }
    
    private static func getWeatherIconFromApiCode(apiCode: String) -> String {
        return "sun.max.fill" // TODO: Process description to icon type.
    }
    
    public static let mockData = LocationStatus(numericData: NumericWeather_ApiData.mockData, descriptiveData: DescriptveWeather_ApiData.mockData);
}

struct LocationWindConditionsData {
    
    let windSpeedMPH: Int;
    let windDirectionDegrees: Double;
    
    static let mockData = LocationWindConditionsData(windSpeedMPH: 8, windDirectionDegrees: 45.0)
}

struct RainfallData {
    let rainfallInches: Int;
    let rainfallDescription: String;
    
    static let mockData = RainfallData(rainfallInches: 0, rainfallDescription: "None expected in next 10 days.")
}

struct LocationFeelsLikeData {
    let feelsLikeDegrees: Float;
    var feelsLikeFormattedString: String {
        String(format: "%.0f", self.feelsLikeDegrees)
    }
    
    let feelsLikeDescription: String;
    
    init(feelsLikeDegrees: Float, currentTemperatureDregrees: Float) {
        self.feelsLikeDegrees = feelsLikeDegrees
        
        if(Int(self.feelsLikeDegrees) == Int(currentTemperatureDregrees)) {
            self.feelsLikeDescription = "The same as the actual temerature."
        }
        else if(self.feelsLikeDegrees < currentTemperatureDregrees - 5) {
            self.feelsLikeDescription = "Colder than the actual temperature."
        }
        else if(self.feelsLikeDegrees > currentTemperatureDregrees + 5) {
            self.feelsLikeDescription = "Hotter than the actual temperature."
        }
        else {
            self.feelsLikeDescription = "Similar to the actual temperature."
        }
    }
    
    init(feelsLikeDegrees: Float, feelsLikeDescription: String) {
        self.feelsLikeDegrees = feelsLikeDegrees;
        self.feelsLikeDescription = feelsLikeDescription;
    }
    
    static let mockData = LocationFeelsLikeData(feelsLikeDegrees: 71, currentTemperatureDregrees: 71)
}

struct LocationHumidityData {
    let humidityPercent: Int;
    let dewPointFahrenheit: Float;
    var dewPointFahrenheitFormattedString: String {
        String(format: "%.0f", self.dewPointFahrenheit)
    }
    
    init(humidityPercent: Int, currentTempFahrenheit: Float) {
        
        self.humidityPercent = humidityPercent;
        self.dewPointFahrenheit = LocationHumidityData.estimateDewPointDegrees(humidityPercent: humidityPercent,
                                                                    currentTempFahrenheit: currentTempFahrenheit)
    }
    
    init(humidityPercent: Int, dewPointDegrees: Float) {
        self.humidityPercent = humidityPercent
        self.dewPointFahrenheit = dewPointDegrees
    }
    
    private static func estimateDewPointDegrees(humidityPercent: Int, currentTempFahrenheit: Float) -> Float {
        
        ///https://www.metric-conversions.org/temperature/fahrenheit-to-celsius.htm
        let tempCelsius = Float(currentTempFahrenheit - 32) / 1.8;
        
        ///https://iridl.ldeo.columbia.edu/dochelp/QA/Basic/dewpoint.html
        
        let dewPointCelsius = tempCelsius - Float((100 - humidityPercent) / 5);
        
        let dewPointFahrenheit = (dewPointCelsius * 1.8) + 32;
        return dewPointFahrenheit;
    }
    
    static let mockData = LocationHumidityData(humidityPercent: 45, dewPointDegrees: 47.0)
}

struct LocationVisibilityData {
    let visibilityMiles: Int;
    let visibilityDescription: String;
    
    init(visibilityMeters: Int) {
        
        /// https://www.unitconverters.net/length/km-to-miles.htm
        self.visibilityMiles = Int(Float(visibilityMeters / 1000) * 0.621371192);
        
        self.visibilityDescription = LocationVisibilityData.GetDescriptionFromVisibleMiles(self.visibilityMiles)
    }
    
    init(visibilityMiles: Int, visibilityDescription: String) {
        self.visibilityMiles = visibilityMiles;
        self.visibilityDescription = visibilityDescription;
    }
    
    private static func GetDescriptionFromVisibleMiles(_ visibilityMiles: Int) -> String {
        //TODO: Add conditional here to return different string based on data.
        return "It's perfectly clear."
    }
    
    static let mockData = LocationVisibilityData(visibilityMiles: 10, visibilityDescription: "It's perfectly clear.")
}

enum AirPressureState {
    case up;
    case neutral;
    case down;
}
struct LocationAirPressureData {
    let airPressure_inHg: Float;
    let airPressureChange: AirPressureState
    
    init(airPressureIn_hPa: Int,
         airPressureChange: AirPressureState) {
        self.airPressureChange = airPressureChange
        
        /// https://www.convertunits.com/from/hpa/to/inhg
        self.airPressure_inHg = Float(airPressureIn_hPa) * 0.02953
    }
    
    init(airPressure_inHg: Float,
         airPressureChange: AirPressureState) {
        self.airPressureChange = airPressureChange
        self.airPressure_inHg = airPressure_inHg
    }
    static let mockData = LocationAirPressureData(airPressure_inHg: 29.95, airPressureChange: .up)
}
