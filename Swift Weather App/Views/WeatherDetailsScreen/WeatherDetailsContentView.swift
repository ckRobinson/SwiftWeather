//
//  WeatherDetailsContentView.swift
//  Swift Weather App
//
//  Created by Cameron on 6/27/23.
//

import SwiftUI

struct WeatherDetailsContentView: View {
    
    let data: LocationCurrentWeatherData
    
    var body: some View {
        ZStack {
            WeatherBackgroundView()
            
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
