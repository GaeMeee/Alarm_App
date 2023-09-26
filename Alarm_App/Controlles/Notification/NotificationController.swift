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
    func notiNext(_ content: Alarm)
}

final class NotificationController: NSObject, NotificationControllerProtocol {
    
    private let unUserNotificationCenter = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        unUserNotificationCenter.delegate = self
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
    
    private func notificationContent(title: String, body: String? = nil) -> UNMutableNotificationContent {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        if let body {
            notificationContent.body = body
        }
        return notificationContent
    }
    
    func notiNext(_ content: Alarm) {
        let notificationContent = notificationContent(title: content.setTime.hourAndMinute, body: content.content)
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: content.setTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "LocalNoti", content: notificationContent, trigger: trigger)
        unUserNotificationCenter.add(request)
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
