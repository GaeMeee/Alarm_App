//
//  NotificationController.swift
//  Alarm_App
//
//  Created by hong on 2023/09/25.
//

import Foundation
import UserNotifications

protocol NotificationControllerProtocol {
    func isAuthorization(_ completion: @escaping (Bool) -> Void)
    func requestAuthorization()
    func notificationRegist(_ content: Alarm)
    func notificationRemove(_ content: Alarm)
    func notificationUpdate(_ content: Alarm)
}

final class NotificationController: NSObject, NotificationControllerProtocol {
    
    private let unUserNotificationCenter = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        unUserNotificationCenter.delegate = self
        notificationCategoriesRegist()
    }
    
    func requestAuthorization() {
        
        unUserNotificationCenter.requestAuthorization(options: [.alert, .sound]) { allow, error in
            if let error {
                print("UNUserNotificationCenter Error Ocurred: \(error)")
            } else {
                if allow {
                    print("UNUserNotificationCenter authorized")
                } else {
                    print("UNUserNotificationCenter not authorized")
                }
            }
        }

    }
    
    func isAuthorization(_ completion: @escaping (Bool) -> Void) {
        if #available(iOS 10.0, *) {
            unUserNotificationCenter.getNotificationSettings { settings in
                if settings.authorizationStatus == .authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } else {
            completion(false)
        }
    }
    
    private func notificationCategoriesRegist() {
        let conformAction = UNNotificationAction(identifier: "ConformAction", title: "확인", options: [])
        let cancelAction = UNNotificationAction(identifier: "SnoozeAction", title: "끄기", options: [.destructive])
        
        let snoonzeActions = [conformAction, cancelAction]
        let nonSnoozeActions = [conformAction]
        
        let snoozeCategory = UNNotificationCategory(
            identifier: "SnoozeCategory",
            actions: snoonzeActions,
            intentIdentifiers: [],
            hiddenPreviewsBodyPlaceholder: "",
            options: .customDismissAction
        )
        
        let nonSnoozeAlarmCategroy = UNNotificationCategory(
            identifier: "NonSnoozeCategory",
            actions: nonSnoozeActions,
            intentIdentifiers: [],
            hiddenPreviewsBodyPlaceholder: "",
            options: .customDismissAction
        )
        
        unUserNotificationCenter.setNotificationCategories([snoozeCategory, nonSnoozeAlarmCategroy])
    }
    
    private func notificationContent(title: String, body: String? = nil, sound: String? = nil, isSnooze: Bool = false) -> UNMutableNotificationContent {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        if let body {
            notificationContent.body = body
        }
        if let sound {
            notificationContent.sound = UNNotificationSound(named: .init(sound))
        } else {
            notificationContent.sound = .default
        }
        notificationContent.categoryIdentifier = isSnooze ? "SnoozeCategory" : "NonSnoozeCategory"
        return notificationContent
    }
    
    func notificationRegist(_ content: Alarm) {
        let notificationContent = notificationContent(
            title: content.setTime.hourAndMinute,
            body: content.content,
            sound: content.notificationSound,
            isSnooze: content.snoozeEnabled
        )
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: content.setTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "Alarm \(content.setTime.hourAndMinute)", content: notificationContent, trigger: trigger)
        unUserNotificationCenter.add(request)
    }
    
    func notificationRemove(_ content: Alarm) {
        unUserNotificationCenter.removePendingNotificationRequests(withIdentifiers: ["Alarm \(content.setTime.hourAndMinute)"])
    }
    
    func notificationUpdate(_ content: Alarm) {
        notificationRemove(content)
        notificationRegist(content)
    }
}

extension NotificationController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .sound, .banner])
    }
}
