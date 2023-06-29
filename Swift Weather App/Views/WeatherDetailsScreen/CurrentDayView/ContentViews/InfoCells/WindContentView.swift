//
//  WindContentView.swift
//  Swift Weather App
//
//  Created by Cameron on 6/14/23.
//

import SwiftUI

struct WindContentView: View {
    
    let windSpeedMPH: Int
    let windDirectionDegrees: Double
    let backgroundColor: Color;
    
    init(windSpeedMPH: Int, windDirectionDegrees: Double, backgroundColor: Color = .blue) {
        self.windSpeedMPH = windSpeedMPH
        self.windDirectionDegrees = windDirectionDegrees
        self.backgroundColor = backgroundColor;
    }
    
    init(conditionsData: LocationWindConditionsData, backgroundColor: Color = .blue) {
        self.windSpeedMPH = conditionsData.windSpeedMPH;
        self.windDirectionDegrees = conditionsData.windDirectionDegrees;
        self.backgroundColor = backgroundColor;
    }
    
    var body: some View {
        VStack {
            ZStack {
                
                WindCompassCircle()
                    .foregroundColor(.gray.opacity(0.5))
                DirectionalArrow(windDirectionDegrees: self.windDirectionDegrees)
                    .frame(maxHeight: 120)
                CompassCardianDirections
                WindSpeedView(windSpeedMPH: self.windSpeedMPH)
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    private func WindCompassCircle() -> some View {
        
        let dotLength: CGFloat = 1;
        let spaceLength: CGFloat = 2;
        
        return Group {
            Circle()
                .stroke(Color("lightBlue"),
                        style: StrokeStyle(lineWidth: 7, lineCap: .butt, lineJoin: .miter,
                                           miterLimit: 0, dash: [dotLength, spaceLength], dashPhase: 0))
                .frame(maxWidth: .infinity)
        }
    }
    
    private func WindSpeedView(windSpeedMPH: Int) -> some View {
        
        VStack {
            Text("\(self.windSpeedMPH)")
                .font(.system(size: 17).bold())
            Text("mph")
                .font(.system(size: 12).bold())
        }
        .foregroundColor(.white)
    }
    
    private var CompassCardianDirections: some View {
        VStack {
            Text("N")

            HStack {
                Text("W")

                Circle()
                    .frame(width: 50)
                    .foregroundColor(self.backgroundColor)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                
                Text("E")
            }
            
            Text("S")
        }
        .font(.system(size: 13).monospaced().bold())
        .foregroundColor(.white)
    }
    
    private func DirectionalArrow(windDirectionDegrees: Double) -> some View {
        
        return Group {
            VStack {
                Image(systemName: "arrowtriangle.up.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .padding(.bottom, -10)
                Rectangle()
                    .frame(width: 2)
                Image(systemName: "circle")
                    .font(.system(size: 10).weight(.black))
                    .padding(.top, -10)
            }
            .foregroundColor(.white)
            .shadow(radius: 1)
            .rotationEffect(.degrees(windDirectionDegrees))
        }
    }
}

struct WindContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WeatherBackgroundView()
            AdditionalDataElementView(title: "Pressure",
                                                imageString: "gauge.medium",
                                                content: WindContentView(conditionsData: LocationCurrentWeatherData.mockData().windData))
        }
    }
}
