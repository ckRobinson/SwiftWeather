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
                        ScrollView {
                            weatherLocationCard()
                                .padding(.top)
                        }
                    case .apiError:
                        Text("Error")
                            .foregroundColor(.white)
                    case .locationError:
                        VStack {
                            Text("Could not load location data. Please search for a location above or try again later.")
                                .foregroundColor(.white)
                                .padding()
                            Spacer()
                        }
                }
            }
            .navigationTitle("Weather")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar(.visible, for: .bottomBar)
            .toolbarBackground(.hidden, for: .bottomBar)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    if(ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1") {
                        Button(action: { viewModel.timeBasedBackgroundState = .morning }, label: {
                            Text("Morning")
                            .padding(5)
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                        })
                        Button(action: { viewModel.timeBasedBackgroundState = .day }, label: {
                            Text("Day")
                            .padding(5)
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                        })
                        Button(action: { viewModel.timeBasedBackgroundState = .evening }, label: {
                            Text("Evening")
                            .padding(5)
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                        })
                        Button(action: { viewModel.timeBasedBackgroundState = .night }, label: {
                            Text("Night")
                            .padding(5)
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                        })
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.updateUserLocation()
                        self.searchText = ""
                    }, label: {
                        Image(systemName: "location")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(5)
                            .background(backgroundColor)
                            .frame(width: 40)
                            .cornerRadius(15)
                            .applyShadow()
                    })
                }
            }
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
                    .applyShadow()
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
