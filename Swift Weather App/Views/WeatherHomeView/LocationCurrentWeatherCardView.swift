//
//  LocationCurrentWeatherCardView.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import SwiftUI

struct LocationCurrentWeatherCardView: View {
    let weatherData: LocationCurrentWeatherData
    init() {
        self.weatherData = LocationCurrentWeatherData.mockData();
    }
    init(weatherData: LocationCurrentWeatherData) {
        self.weatherData = weatherData;
    }
    
    var body: some View {
        VStack {
            HStack {
                locationInfo
                Spacer()
                locationCurrentTemp
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                locationCurrentWeatherDescription
                Spacer()
                locationCurrentHighLowTemp
            }
        }
        .padding()
    }
    
    var locationInfo: some View {
        VStack(alignment: .leading) {
            Text(weatherData.locationName)
                .font(.system(size: 18).bold())
                .foregroundColor(.white)
            Text("\(weatherData.localTime)")
                .font(.system(size: 15))
                .foregroundColor(.white)
        }
    }
    
    var locationCurrentTemp: some View {
        Text("\(String(format: "%.2f", weatherData.currentTemp))\u{00B0}")
            .font(.system(size: 20).bold())
            .foregroundColor(.white)
    }
    
    var locationCurrentWeatherDescription: some View {
        HStack {
            Text(weatherData.dayWeatherDescription)
                .font(.system(size: 12))
                .foregroundColor(.white)
            Image(systemName: weatherData.weatherIconName)
                .renderingMode(.original)
                .resizable()
                .frame(width: 15, height: 15)
        }
    }
    
    var locationCurrentHighLowTemp: some View {
        HStack {
            Text("H: \(String(format: "%.2f", weatherData.dayMaxTemp))\u{00B0}")
                .font(.system(size: 12).bold())
                .foregroundColor(.white)
            
            Text("L: \(String(format: "%.2f", weatherData.dayMinTemp))\u{00B0}")
                .font(.system(size: 12).bold())
                .foregroundColor(.white)
        }
    }
}

struct LocationCurrentWeatherCardView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            WeatherBackgroundView()
            LocationCurrentWeatherCardView()
                .background(.blue)
                .cornerRadius(15)
                .shadow(radius: 1, x: 1, y: 1)
                .padding()
        }
    }
}
