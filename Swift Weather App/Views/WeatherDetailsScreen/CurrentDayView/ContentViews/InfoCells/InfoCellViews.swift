//
//  InfoCellViews.swift
//  Swift Weather App
//
//  Created by Cameron on 6/28/23.
//

import SwiftUI

// MARK: - Feels Like View
struct FeelsLikeContentView: View {
    
    let data: LocationFeelsLikeData;
    init(feelsLikeTemperature: Float, feelsLikeDescription: String) {
        self.data = LocationFeelsLikeData(feelsLikeDegrees: feelsLikeTemperature,
                                             feelsLikeDescription: feelsLikeDescription);
    }
    init(data: LocationFeelsLikeData) {
        self.data = data;
    }
    
    var body: some View {
        TwoLineContentView(mainContent: "\(self.data.feelsLikeFormattedString)\u{00B0}",
                                  subContent: self.data.feelsLikeDescription)
    }
}

// MARK: - Rainfall View
struct RainfallContentView: View {
    
    let amountOfRainfallInches: Int
    let rainfallDescription: String
    init(rainfallInches amountOfRainfallInches: Int, rainfallDescription: String) {
        self.amountOfRainfallInches = amountOfRainfallInches
        self.rainfallDescription = rainfallDescription;
    }
    
    init(data: RainfallData) {
        self.amountOfRainfallInches = data.rainfallInches
        self.rainfallDescription = data.rainfallDescription;
    }
    
    var body: some View {
        VStack {
            Text("\(self.amountOfRainfallInches)\u{201D}")
                .font(.system(size: 35))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white.opacity(0.9))
            
            Text("in last 24 hrs")
                .font(.system(size: 18).bold())
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
            
            Spacer()
            
            Text(self.rainfallDescription)
                .font(.system(size: 16))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white.opacity(0.75))
            
        }
        .frame(maxHeight: .infinity)
        .padding(.horizontal)
    }
}

// MARK: - Humidity View
struct HumidityContentView: View {
    
    let data: LocationHumidityData;
    init(humidityPercent: Int, dewPoint: Float) {
        self.data = LocationHumidityData(humidityPercent: humidityPercent,
                                 dewPointDegrees: dewPoint)
    }
    init(data: LocationHumidityData) {
        self.data = data;
    }
    
    var body: some View {
        TwoLineContentView(mainContent: "\(self.data.humidityPercent)%",
                                  subContent: "The dew point is \(self.data.dewPointFahrenheitFormattedString)\u{00B0} right now.")
    }
}

// MARK: - Visibility View
struct VisibilityContentView: View {
    
    let visibilityMiles: Int;
    let visibilityDescription: String;
    
    init(visibilityMiles: Int, description: String) {
        self.visibilityMiles = visibilityMiles
        self.visibilityDescription = description;
    }
    
    init(data: LocationVisibilityData) {
        self.visibilityMiles = data.visibilityMiles;
        self.visibilityDescription = data.visibilityDescription;
    }
    
    var body: some View {
        TwoLineContentView(mainContent: "\(self.visibilityMiles) mi", subContent: self.visibilityDescription)
    }
}

// MARK: - Preview
struct AdditionalInfoViews_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WeatherBackgroundView()
            
            ScrollView {
                AdditionalDataElementView(title: "Feels Like",
                                                    imageString: "thermometer.medium",
                                                    content: FeelsLikeContentView(feelsLikeTemperature: 71,
                                                                                  feelsLikeDescription: "Similar to the actual temperature."))
                .frame(height: 200)
                AdditionalDataElementView(title: "Rainfall",
                                                    imageString: "drop.fill",
                                                    content: RainfallContentView(rainfallInches: 0,
                                                                             rainfallDescription: "None expected in next 10 days."))
                .frame(height: 200)
                AdditionalDataElementView(title: "Humidity", imageString: "humidity",
                                                    content: HumidityContentView(humidityPercent: 45, dewPoint: 47.0))
                .frame(height: 200)
                AdditionalDataElementView(title: "Visibility",
                                                    imageString: "eye.fill",
                                                    content: VisibilityContentView(visibilityMiles: 10,
                                                                                   description: "It's perfectly clear."))
                .frame(height: 200)
            }
        }
    }
}
