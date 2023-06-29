//
//  CurrentDayAdditionalDataView.swift
//  Swift Weather App
//
//  Created by Cameron Robinson on 6/13/23.
//

import SwiftUI

struct CurrentDayAdditionalDataView: View {
    
    let data: LocationCurrentWeatherData;
    let backgroundColor: Color;
    init(data: LocationCurrentWeatherData) {
        self.data = data
        self.backgroundColor = TimeOfDay.timeOfDayToCardBGColor(timeOfDay: self.data.locationInfo.locationTimeOfDay);
    }
    
    var body: some View {
        let grid: [GridItem] = [
            GridItem(.fixed(180), alignment: .top),
            GridItem(.fixed(180), alignment: .top)
        ]
        LazyVGrid(columns: grid) {
//            AdditionalDataElementView(title: "UV Index", imageString: "sun.max.fill")
//            AdditionalDataElementView(title: "Sunset", imageString: "sunset.fill")
            AdditionalDataElementView(title: "Wind", imageString: "wind",
                                      backgroundColor: self.backgroundColor,
                                      content: WindContentView(conditionsData: data.windData,
                                                               backgroundColor: self.backgroundColor))
//            AdditionalDataElementView(title: "Rainfall", imageString: "drop.fill",
//                                      content: RainfallContentView(data: data.rainfall))
            AdditionalDataElementView(title: "Feels Like", imageString: "thermometer.medium",
                                      backgroundColor: self.backgroundColor,
                                      content: FeelsLikeContentView(data: data.feelsLike))
            AdditionalDataElementView(title: "Humidity", imageString: "humidity",
                                      backgroundColor: self.backgroundColor,
                                      content: HumidityContentView(data: data.humidity))
            AdditionalDataElementView(title: "Visibility", imageString: "eye.fill",
                                      backgroundColor: self.backgroundColor,
                                      content: VisibilityContentView(data: data.visibility))
            AdditionalDataElementView(title: "Pressure", imageString: "gauge.medium",
                                      backgroundColor: self.backgroundColor,
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


