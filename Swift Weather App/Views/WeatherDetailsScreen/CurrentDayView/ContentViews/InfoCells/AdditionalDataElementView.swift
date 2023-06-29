//
//  AdditionalDataElementView.swift
//  Swift Weather App
//
//  Created by Cameron on 6/14/23.
//

import SwiftUI

struct AdditionalDataElementView: View {
    
    let title: String
    let imageString: String
    let content: any View // If there is no content we render an empty view, is case for UV Index and Sunset in screenshot.
    let backgroundColor: Color;
    init(title: String, imageString: String, backgroundColor: Color = .blue) {
        self.title = title
        self.imageString = imageString
        self.content = EmptyView()
        self.backgroundColor = backgroundColor;
    }
    
    init(title: String, imageString: String, backgroundColor: Color = .blue, content: any View) {
        self.title = title;
        self.imageString = imageString;
        self.content = content;
        self.backgroundColor = backgroundColor;
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: imageString)
                
                Text(title)
                    .font(.system(size: 15).bold())
                    .textCase(.uppercase)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.horizontal)
            .padding(.top)
            .foregroundColor(.white)
            
            AnyView(self.content)
        }
        .padding(.bottom)
        .frame(minWidth: 180, maxWidth: 180)
        .background(self.backgroundColor.opacity(0.5))
        .cornerRadius(15)
        .shadow(radius: 1, x: 2, y: 2)
    }
}

struct AdditionalWeatherDataElementView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WeatherBackgroundView()
            VStack {
                AdditionalDataElementView(title: "Wind", imageString: "wind")
                    .frame(height: 200)
                AdditionalDataElementView(title: "Wind", imageString: "wind",
                                                    content: HumidityContentView(humidityPercent: 45, dewPoint: 47))
                    .frame(height: 200)
            }
        }
    }
}
