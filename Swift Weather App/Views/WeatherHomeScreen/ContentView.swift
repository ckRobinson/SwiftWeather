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
    @State var backgroundColor: Color = .blue;

    var body: some View {
        
        NavigationStack {
            ZStack {
                WeatherBackgroundView(backgroundState: viewModel.timeBasedBackgroundState)
                
                switch viewModel.state {
                    case .initial:
                        EmptyView()
                    case .loading:
                        VStack {
                            Text("Loading...")
                                .foregroundColor(.white)
                            ProgressView()
                        }
                    case .loaded:
                        VStack {
                            weatherLocationCard()
                                .padding(.top)
                            Spacer()
                            
                            Button(action: {
                                viewModel.updateUserLocation()
                            }, label: {
                                Image(systemName: "location")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(8)
                                    .background(backgroundColor)
                                    .frame(width: 40)
                                    .cornerRadius(15)
                                    .padding(.bottom)
                            })
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing)
                        }
                    case .apiError:
                        Text("Error")
                            .foregroundColor(.white)
                    case .locationError:
                        Text("Location Error")
                            .foregroundColor(.white)
                }
            }
            .navigationTitle("Weather")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .tint(.white)
        .onAppear() {
            viewModel.viewHasAppeared();
            backgroundColor = TimeOfDay.timeOfDayToCardBGColor(timeOfDay: viewModel.timeBasedBackgroundState)
        }
        .searchable(text: $searchText, prompt: "Search for a city/state")
        .onSubmit(of: .search) {
            viewModel.fetchWeatherBy(search: searchText)
        }
        .onChange(of: viewModel.timeBasedBackgroundState, perform: { value in
            backgroundColor = TimeOfDay.timeOfDayToCardBGColor(timeOfDay: value)
        })
    }
    
    private func weatherLocationCard() -> some View {
        
        return Group {
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
                    .background(backgroundColor)
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
