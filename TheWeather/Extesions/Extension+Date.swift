//
//  Extension+Date.swift
//  TheWeather
//
//  Created by Иван Луганцов on 25.05.2023.
//

import Foundation

enum DayPeriod: String {
    case morning
    case day
    case evening
    case night
}

extension Date {
    
    func formateDateFull(timezone: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timezone)
        dateFormatter.dateFormat = "MMM d, EEE, hh:mm a"
        dateFormatter.locale = Locale.current
        
        return dateFormatter.string(from: self)
    }
    
    func formateDate(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getDayPeriod(timezone: String, sunrise: String, sunset: String) -> DayPeriod {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timezone)
        dateFormatter.dateFormat = "HH"
        dateFormatter.locale = Locale.current
        
        let stringHour = dateFormatter.string(from: self)
        guard let currentTime = Int(stringHour) else { return .day }
        
        let sunrise = sunrise.numberOfHours()
        let sunset = sunset.numberOfHours()
        
        let sunTime = sunset - sunrise
        
        let motning = currentTime > sunrise - 1 && currentTime < sunTime / 3
        let day = currentTime > sunTime / 3 && currentTime < sunTime - sunTime / 3
        let evening = currentTime > sunTime - sunTime / 3 && currentTime < sunset + 1
    
        if motning {
            return .morning
        } else if day {
            return .day
        } else if evening {
            return .evening
        } else {
            return .night
        }
    }
}
