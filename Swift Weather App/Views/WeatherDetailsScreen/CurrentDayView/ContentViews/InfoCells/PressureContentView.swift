//
//  PressureContentView.swift
//  Swift Weather App
//
//  Created by Cameron on 6/14/23.
//

import SwiftUI

struct PressureContentView: View {
    
    let airPressure: Float;
    let airPressureChange: AirPressureState;
    let pressureGraphRotation: Double = 0.0;
    init(airPressure: Float, airPressureChange: AirPressureState) {
        self.airPressure = airPressure
        self.airPressureChange = airPressureChange;
    }
    
    init(data: LocationAirPressureData) {
        self.airPressure = data.airPressure_inHg;
        self.airPressureChange = data.airPressureChange;
    }
    
    var body: some View {
        VStack {
            ZStack {
                
                DashedCircle()
                    .foregroundColor(.gray.opacity(0.75))
                PressureLine()
                    .rotationEffect(.degrees(self.pressureGraphRotation))
                PressureTextInnerField()
            }
            .padding(.horizontal)
            .padding(.bottom, -25)
            
            HStack {
                Text("Low")
            
                Spacer()
            
                Text("High")
            }
            .foregroundColor(.white)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .padding(.top, 5)
    }
    
    private func DashedCircle() -> some View {
        
        let dotLength: CGFloat = 2;
        let spaceLength: CGFloat = 4;
        return Group {
            Circle()
                .trim(from: 0, to: 0.71)
                .stroke(.white,
                        style: StrokeStyle(lineWidth: 11, lineCap: .butt, lineJoin: .miter,
                                           miterLimit: 0, dash: [dotLength, spaceLength], dashPhase: 0))
                .frame(maxWidth: .infinity)
                .rotationEffect(.degrees(-215))
        }
    }
    
    private func PressureLine() -> some View {
        let dotLength: CGFloat = 25;
        let spaceLength: CGFloat = 360 + 25;
        return Group {
            if(self.airPressureChange != .neutral) {
                Circle()
                //            .trim(from: 0, to: 0.1)
                    .stroke(LinearGradient(colors: [.white.opacity(0), .white], startPoint: .center, endPoint: .bottomTrailing),
                            style: StrokeStyle(lineWidth: 11, lineCap: .butt, lineJoin: .miter,
                                               miterLimit: 0, dash: [dotLength, spaceLength], dashPhase: 0))
                    .frame(maxWidth: .infinity)
                    .rotationEffect(.degrees(-115.5))
            }
            
            Capsule()
                .foregroundColor(.white)
                .frame(width: 4, height: 20)
                .offset(x: 0, y: -57)
        }
    }
    
    private func PressureTextInnerField() -> some View {
        VStack {
            if(self.airPressureChange == .up) {
                Image(systemName: "arrow.up")
                    .font(.system(size: 20).bold())
            }
            else if(self.airPressureChange == .down) {
                Image(systemName: "arrow.down")
                    .font(.system(size: 20).bold())
            }
            else {
                Image(systemName: "equal")
                    .font(.system(size: 20).bold())
            }

            Text("\(String(format: "%.2f", self.airPressure))")
                .font(.system(size: 25).bold())
            Text("inHg")
        }
        .foregroundColor(.white)
    }

}

struct PressureContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WeatherBackgroundView()
            AdditionalDataElementView(title: "Pressure",
                                                imageString: "gauge.medium",
                                                content: PressureContentView(airPressure: 29.95, airPressureChange: .up))
        }
    }
}
