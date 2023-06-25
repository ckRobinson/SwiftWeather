//
//  BackgroundView.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import SwiftUI

enum BackgroundColorState {
    case defaultDay;
    case sunSet;
    case night;
}

struct WeatherBackgroundView: View {
    
    let backgroundState: BackgroundColorState
    init() {
        self.backgroundState = .defaultDay
    }
    init(backgroundState: BackgroundColorState) {
        self.backgroundState = backgroundState;
    }
    
    var body: some View {
        
        switch(self.backgroundState) {
        case .defaultDay:
            LinearGradient(colors: [.teal, .blue, .init(red: 0.2, green: 0.2, blue: 1)],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(.all)
        case .sunSet:
            LinearGradient(colors: [.orange, .init(red: 0.1, green: 0.1, blue: 0.5)],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(.all)
        case .night:
            LinearGradient(colors: [.indigo, .init(red: 0.1, green: 0.1, blue: 0.5)],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(.all)
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherBackgroundView(backgroundState: .defaultDay)
    }
}
