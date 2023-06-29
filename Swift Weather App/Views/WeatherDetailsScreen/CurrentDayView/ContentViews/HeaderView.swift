//
//  HeaderView.swift
//  Swift Weather App
//
//  Created by Cameron on 6/13/23.
//

import SwiftUI

struct HeaderView: View {
    
    let locationInfo: LocationInfo;
    let locationStatus: LocationStatus;
    var body: some View {
        VStack {
            Text(locationInfo.name)
                .font(.system(size: 35))
                .foregroundColor(.white)
            
            Text("\(locationStatus.temperatureFormattedString)\u{00B0}")
                .font(.system(size: 100, weight: .thin))
                .foregroundColor(.white)
            
            Text(locationStatus.description)
                .font(.system(size: 20).bold())
                .foregroundColor(.white.opacity(0.9))
            
            HStack {
                Text("H: \(locationStatus.dailyHighFormattedString)\u{00B0}")
                    .font(.system(size: 25).bold())
                Text("L: \(locationStatus.dailyLowFormattedString)\u{00B0}")
                    .font(.system(size: 25).bold())
            }
            .foregroundColor(.white.opacity(0.75))
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WeatherBackgroundView()
            HeaderView(locationInfo: LocationInfo.mockData,
                       locationStatus: LocationStatus.mockData)
        }
    }
}
