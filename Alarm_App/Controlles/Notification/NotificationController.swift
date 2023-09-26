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
}

struct NotificationController: NotificationControllerProtocol {
    
    private let unUserNotificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { allow, error in
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
            UNUserNotificationCenter.current().getNotificationSettings { settings in
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
}
