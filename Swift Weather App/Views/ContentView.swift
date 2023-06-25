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
                        LocationCurrentWeatherCardView(weatherData: weatherData)
                            .padding(.horizontal)
                            .padding(.top)
                            .padding(.bottom, 3)
                    }
                    Spacer()
                }
            }
            .navigationTitle("Weather")
        }
        .onAppear() {
            viewModel.updateWeatherData()
        }
        .searchable(text: $searchText, prompt: "Search for a city/state")
        .onSubmit(of: .search) {
            viewModel.fetchWeatherBy(search: searchText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
