//
//  ContentView.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: WeatherDataViewModel = WeatherDataViewModel()
    @State var searchText = "";
    var body: some View {
        
        NavigationStack {
            ZStack {
                WeatherBackgroundView()
                
                VStack {
                    if let weatherData = viewModel.weatherData {
                        WeatherContent(weatherData: weatherData)
                            .padding(.horizontal)
                            .padding(.top)
                            .padding(.bottom, 3)
                    }
                    Spacer()
                }
            }
            .navigationTitle("Weather")
        }
        .searchable(text: $searchText, prompt: "Search for a city/state")
        .onAppear() {
            viewModel.updateWeatherData()
        }
    }
}

struct WeatherContent: View {
    
    let weatherData: WeatherData
    init() {
        self.weatherData = WeatherData(originalData: WeatherModel.mockData);
    }
    init(weatherData: WeatherData) {
        self.weatherData = weatherData;
    }
    
    var body: some View {
        VStack {
            
            HStack {
                VStack(alignment: .leading) {
                    Text(weatherData.coreData.name)
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                    Text("\(weatherData.time)")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                }
                .padding(.leading)
                
                Spacer()
                
                Text("\(String(format: "%.2f", weatherData.coreData.main.temp))\u{00B0}")
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .padding(.trailing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)

            
            HStack {
                Text(weatherData.coreData.weather[0].description.capitalized)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(.leading)
                Image(systemName: weatherData.weatherImage)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 15, height: 15)
                
                Spacer()
                
                HStack {
                    Text("H: \(String(format: "%.2f", weatherData.coreData.main.temp_max))\u{00B0}")
                        .font(.system(size: 12).bold())
                        .foregroundColor(.white)
                    
                    Text("L: \(String(format: "%.2f", weatherData.coreData.main.temp_min))\u{00B0}")
                        .font(.system(size: 12).bold())
                        .foregroundColor(.white)
                }
                .padding(.trailing)
            }
            .padding(.bottom)
            
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
