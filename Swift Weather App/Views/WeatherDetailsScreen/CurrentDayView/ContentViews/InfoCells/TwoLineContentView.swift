//
//  TwoLineContentView.swift
//  Swift Weather App
//
//  Created by Cameron on 6/14/23.
//

import SwiftUI

struct TwoLineContentView: View {
    
    let mainContent: String;
    let subContent: String;
    var body: some View {
        VStack {
            Text(mainContent)
                .font(.system(size: 35))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white.opacity(0.9))
            
            Spacer(minLength: 20)
            
            Text(self.subContent)
                .font(.system(size: 16))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white.opacity(0.75))
        }
        .frame(maxHeight: .infinity)
        .padding(.horizontal)
    }
}

struct TwoLineWeatherContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WeatherBackgroundView()
            AdditionalDataElementView(title: "Feels Like",
                                      imageString: "thermometer.",
                                      content: TwoLineContentView(mainContent: "71\u{00B0}",
                                                                  subContent: "Similar to the actual temperature."))
            .frame(height: 200)
        }
    }
}
