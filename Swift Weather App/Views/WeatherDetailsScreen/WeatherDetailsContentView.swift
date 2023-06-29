//
//  WeatherDetailsContentView.swift
//  Swift Weather App
//
//  Created by Cameron on 6/27/23.
//

import SwiftUI

struct WeatherDetailsContentView: View {
    
    let data: LocationCurrentWeatherData
    let backgroundState: BackgroundState

    init(data: LocationCurrentWeatherData) {
        self.data = data
        self.backgroundState = .day
    }
    init(data: LocationCurrentWeatherData, backgroundState: BackgroundState) {
        self.data = data
        self.backgroundState = backgroundState
    }
    
    var body: some View {
        ZStack {
            WeatherBackgroundView(backgroundState: backgroundState)

            ScrollView(showsIndicators: false) {
                HeaderView(locationInfo: data.locationInfo,
                           locationStatus: data.locationStatus)
                
//                CurrentDayCoreInfoView(data: locationData.currentDay)
//                    .padding(.horizontal)
//                    .padding(.top)
//                    .padding(.bottom, 3)
//
//                TenDayForcastView(tenDayForcastData: locationData.tenDayForecastData)
//                    .padding(.horizontal)
//                    .padding(.bottom, 30)
//
                CurrentDayAdditionalDataView(data: data)
                    .padding(.horizontal)
            }
        }
    }
}

struct WeatherDetailsContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsContentView(data: LocationCurrentWeatherData.mockData())
    }
}
