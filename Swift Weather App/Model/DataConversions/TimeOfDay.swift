//
//  TimeOfDay.swift
//  Swift Weather App
//
//  Created by Cameron on 6/27/23.
//

import Foundation
import SwiftUI

enum TimeOfDay {
    case morning;
    case day;
    case evening;
    case night;
    
    public static func timeOfDayToCardBGColor(timeOfDay: TimeOfDay) -> Color {
        switch(timeOfDay) {
        case .day:
            return .blue;
        case .morning:
            return Color("cardMorningColor");
        case .evening:
            return Color("cardEveningColor");
        case .night:
            return Color("cardNightColor");
        }
    }
    
    /**
     TODO: Add function to convert from current timecode and sunset, sunrise timecodes to night, morning
     day, evening.
     */
    public static func parseDateToBackgroundState(date: Date) -> TimeOfDay {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let currentHour24hClock = formatter.string(from: date)
        
        switch(currentHour24hClock) {
        case "0":
            fallthrough;
        case "1":
            fallthrough;
        case "2":
            fallthrough;
        case "3":
            fallthrough;
        case "4":
            fallthrough;
        case "5":
            return .night;
        case "6":
            fallthrough;
        case "7":
            fallthrough;
        case "8":
            return .morning
        case "9":
            fallthrough;
        case "10":
            fallthrough
        case "11":
            fallthrough;
        case "12":
            fallthrough;
        case "13":
            fallthrough;
        case "14":
            fallthrough;
        case "15":
            return .day
        case "16":
            fallthrough
        case "17":
            fallthrough
        case "18":
            return .evening
        case "19":
            fallthrough
        case "20":
            fallthrough
        case "21":
            fallthrough
        case "22":
            fallthrough
        case "23":
            fallthrough
        case "24":
            return .night
        default:
            break;
        }
        
        return .day
    }
}
