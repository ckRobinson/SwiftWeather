//
//  ContentView.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: WeatherDataViewModel = WeatherDataViewModel()
    var body: some View {
        
        ZStack {
            WeatherBackgroundView()
            
            if let weatherData = viewModel.weatherData {
                WeatherContent()
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 3)
            }
        }
        .navigationTitle("Weather")
        .onAppear() {
            viewModel.updateWeatherData()
        }
    }
    

}

struct WeatherContent: View {
    
    let weatherData: WeatherModel
    init() {
        self.weatherData = WeatherModel.mockData
    }
    init(weatherData: WeatherModel) {
        self.weatherData = weatherData;
    }
    
    var body: some View {
        VStack {
            
            Text(weatherData.name)
                .font(.system(size: 15))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.leading)
            
        }
        .background(.blue)
        .cornerRadius(15)
        .shadow(radius: 1, x: 1, y: 1)
    }
}

struct WeatherBackgroundView: View {
    
    var body: some View {
        LinearGradient(colors: [.teal, .blue, .init(red: 0.2, green: 0.2, blue: 1)],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
