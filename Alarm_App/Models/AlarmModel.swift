//
//  Alarm.swift
//  Alarm_App
//
//  Created by hong on 2023/09/25.
//

import Foundation

struct Alarm: Codable {
    var id: String = UUID().uuidString
    let date: Date
    var isOn: Bool
    
    var time: String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        return timeFormatter.string(from: date)
    }
    
    var meridiem: String {
        let meridiemFormatter = DateFormatter()
        meridiemFormatter.dateFormat = "a"
        meridiemFormatter.locale = Locale(identifier: "ko")
        return meridiemFormatter.string(from: date)
    }
}

struct AlarmModel: Codable {
    var setTime: Date
    var content: String
    var notificationSound: String
    var snoozeEnabled: Bool
    var isNotificationEnabled: Bool
}
