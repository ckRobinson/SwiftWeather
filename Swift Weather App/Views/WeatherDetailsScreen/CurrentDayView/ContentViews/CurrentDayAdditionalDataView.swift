//
//  CurrentDayAdditionalDataView.swift
//  Swift Weather App
//
//  Created by Cameron Robinson on 6/13/23.
//

import SwiftUI

struct CurrentDayAdditionalDataView: View {
    
    let data: LocationCurrentWeatherData

    var body: some View {
        let grid: [GridItem] = [
            GridItem(.fixed(180), alignment: .top),
            GridItem(.fixed(180), alignment: .top)
        ]
        LazyVGrid(columns: grid) {
//            AdditionalDataElementView(title: "UV Index", imageString: "sun.max.fill")
//            AdditionalDataElementView(title: "Sunset", imageString: "sunset.fill")
            AdditionalDataElementView(title: "Wind", imageString: "wind",
                                      content: WindContentView(conditionsData: data.windData))
//            AdditionalDataElementView(title: "Rainfall", imageString: "drop.fill",
//                                      content: RainfallContentView(data: data.rainfall))
            AdditionalDataElementView(title: "Feels Like", imageString: "thermometer.medium",
                                      content: FeelsLikeContentView(data: data.feelsLike))
            AdditionalDataElementView(title: "Humidity", imageString: "humidity",
                                      content: HumidityContentView(data: data.humidity))
            AdditionalDataElementView(title: "Visibility", imageString: "eye.fill",
                                      content: VisibilityContentView(data: data.visibility))
            AdditionalDataElementView(title: "Pressure", imageString: "gauge.medium",
                                      content: PressureContentView(data: data.airPressure))
        }
    }
}

struct CurrentDayAdditionalDataView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WeatherBackgroundView()
            ScrollView(.vertical) {
                CurrentDayAdditionalDataView(data: LocationCurrentWeatherData.mockData());
            }
        }
    }
}


