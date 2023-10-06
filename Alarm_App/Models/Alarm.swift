//
//  Alarm.swift
//  Alarm_App
//
//  Created by hong on 2023/09/25.
//

import Foundation

struct Alarm: Codable {
    var setTime: Date
    var content: String = "알람 시간입니다. 지금 활동을 시작하세요!"
    var notificationSound: String = "default.mp3"
    var snoozeEnabled: Bool = false
    var isNotificationEnabled: Bool = false
    
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
