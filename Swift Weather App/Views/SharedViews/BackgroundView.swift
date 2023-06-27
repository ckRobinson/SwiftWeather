//
//  BackgroundView.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import SwiftUI

struct WeatherBackgroundView: View {
    
    let backgroundState: BackgroundState
    let lightPurple = Color.init(red: 0.1, green: 0.1, blue: 0.5)
    let lightBlue = Color.init(red: 0.3, green: 0.5, blue: 1)
    let lightFadedBlue = Color.init(red: 0.3, green: 0.5, blue: 1)
    init() {
        self.backgroundState = .day
    }
    init(backgroundState: BackgroundState) {
        self.backgroundState = backgroundState;
    }
    
    var body: some View {
        
        switch(self.backgroundState) {
        case .morning:
            LinearGradient(colors: [.teal, .teal, .blue, .indigo, lightPurple],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(.all)
        case .day:
            LinearGradient(colors: [lightBlue, .blue, .teal],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(.all)
        case .evening:
            LinearGradient(colors: [.indigo, .purple.opacity(0.95), lightBlue, lightFadedBlue],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(.all)
        case .night:
            LinearGradient(colors: [lightPurple, .indigo],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(.all)
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherBackgroundView(backgroundState: .evening)
    }
}
