//
//  Alarm.swift
//  Alarm_App
//
//  Created by hong on 2023/09/25.
//

import Foundation

struct AlarmModel: Codable {
    var setTime: Date
    var content: String
    var notificationSound: String
    var snoozeEnabled: Bool
    var isNotificationEnabled: Bool
}
