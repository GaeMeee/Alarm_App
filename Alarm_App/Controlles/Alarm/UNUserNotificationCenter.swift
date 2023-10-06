//
//  UNUserNotificationCenter.swift
//  practiceAlarm
//
//  Created by 김지훈 on 2023/10/03.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    func addNotificationRequest(by alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "시계"
        content.subtitle = "알람 시간: \(formattedTime(from: alarm.date))"
        content.body = "알람 시간입니다. 지금 활동을 시작하세요!"
//        content.sound = .default
        content.sound = UNNotificationSound(named: UNNotificationSoundName("siren.mp3"))
        content.badge = 1
        
        let component = Calendar.current.dateComponents([.hour, .minute], from: alarm.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: alarm.isOn)
        let request = UNNotificationRequest(identifier: alarm.id, content: content, trigger: trigger)
        
        self.add(request, withCompletionHandler: nil)
    }
    
    private func formattedTime(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
