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
            return Color("cardDayColor");
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
    public static func parseDateToBackgroundState(date: Date, timezoneOffset: Int = 0) -> TimeOfDay {
        
        let formatter = DateFormatter();
        formatter.timeZone = TimeZone(secondsFromGMT: timezoneOffset);
        formatter.dateFormat = "HH";
        
        let currentHour24hClock = formatter.string(from: date)
        
        switch(currentHour24hClock) {
        case "21":
            fallthrough;
        case "22":
            fallthrough;
        case "23":
            fallthrough;
        case "24":
            fallthrough;
        case "00":
            fallthrough;
        case "01":
            fallthrough;
        case "02":
            fallthrough;
        case "03":
            fallthrough;
        case "04":
            fallthrough;
        case "05":
            return .night;
        case "06":
            fallthrough;
        case "07":
            fallthrough;
        case "08":
            return .morning
        case "09":
            fallthrough;
        case "10":
            fallthrough;
        case "11":
            fallthrough;
        case "12":
            fallthrough;
        case "13":
            fallthrough;
        case "14":
            fallthrough;
        case "15":
            fallthrough;
        case "16":
            fallthrough;
        case "17":
            return .day
        case "18":
            fallthrough;
        case "19":
            fallthrough;
        case "20":
            return .evening;
        default:
            break;
        }
        
        return .day
    }
}
