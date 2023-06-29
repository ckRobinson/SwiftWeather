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
                locationInfo(info: self.weatherData.locationInfo)
                Spacer()
                currentTemp(currentStatus: self.weatherData.locationStatus)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                currentWeatherDescription(currentStatus: self.weatherData.locationStatus)
                Spacer()
                currentHighLowTemp(currentStatus: self.weatherData.locationStatus)
            }
        }
        .padding()
    }
    
    private func locationInfo(info: LocationInfo) -> some View {
        VStack(alignment: .leading) {
            Text(info.name)
                .font(.system(size: 18).bold())
            Text("Last Updated: \(info.localTime)")
                .font(.system(size: 13))
            Text("(\(info.name) Time)")
                .font(.system(size: 12))
        }
        .foregroundColor(.white)
    }
    
    private func currentTemp(currentStatus: LocationStatus)
    -> some View {
        Text("\(currentStatus.temperatureFormattedString)\u{00B0}")
            .font(.system(size: 20).bold())
            .foregroundColor(.white)
    }
    
    private func currentWeatherDescription(currentStatus: LocationStatus)
    -> some View {
        HStack {
            Text(currentStatus.description)
                .font(.system(size: 12))
                .foregroundColor(.white)
            Image(systemName: currentStatus.iconPath)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15)
        }
    }
    
    private func currentHighLowTemp(currentStatus: LocationStatus)
    -> some View {
        HStack {
            Text("H: \(currentStatus.dailyHighFormattedString)\u{00B0}")
                .font(.system(size: 12).bold())
                .foregroundColor(.white)
            
            Text("L: \(currentStatus.dailyLowFormattedString)\u{00B0}")
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
