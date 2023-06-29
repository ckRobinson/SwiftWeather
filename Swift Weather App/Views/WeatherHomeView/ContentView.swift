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
                WeatherBackgroundView(backgroundState: viewModel.timeBasedBackgroundState)
                
                VStack {
                    weatherLocationCard()
                    Spacer()
                }
            }
            .navigationTitle("Weather")
        }
        .onAppear() {
            viewModel.viewHasAppeared();
        }
        /// Searchable tutorial:
        /// https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-a-search-bar-to-filter-your-data
        .searchable(text: $searchText, prompt: "Search for a city/state")
        .onSubmit(of: .search) {
            viewModel.fetchWeatherBy(search: searchText)
        }
    }
    
    private func weatherLocationCard() -> some View {
        Group {
            if let userLocation = viewModel.userLocation {
                NavigationLink(destination: {
                    WeatherDetailsContentView(data: userLocation,
                                              backgroundState: viewModel.timeBasedBackgroundState)
                }, label: {
                    HStack {
                        LocationCurrentWeatherCardView(weatherData: userLocation)
                        
                        Image(systemName: "chevron.right")
                            .fontWeight(Font.Weight.medium)
                            .padding(.trailing)
                            .foregroundColor(.white)
                    }
                    .background(.blue)
                    .cornerRadius(15)
                    .shadow(radius: 1, x: 1, y: 1)
                    .padding(.horizontal)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
