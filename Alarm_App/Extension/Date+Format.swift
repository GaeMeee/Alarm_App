//
//  Date+Format.swift
//  Alarm_App
//
//  Created by hong on 2023/09/26.
//

import Foundation

extension Date {
    enum dateFormat: String {
        case HourAndMinute = "HH:mm"
    }
    
    func formattedString(_ format: dateFormat, local: String = "kor") -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .autoupdatingCurrent
        formatter.locale = .current
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }

    /// EX: "10:00"
    var hourAndMinute: String {
        formattedString(.HourAndMinute)
    }
}
