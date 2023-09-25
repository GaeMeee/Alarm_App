//
//  CustomTabBarController.swift
//  Alarm_App
//
//  Created by JeonSangHyeok on 2023/09/25.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let alarmVC = AlarmViewController()
        alarmVC.tabBarItem = UITabBarItem(title: "알람", image: UIImage(systemName: "alarm.fill"), tag: 0)
        
        let timerVC = TimerViewController()
        timerVC.tabBarItem = UITabBarItem(title: "타이머", image: UIImage(systemName: "timer"), tag: 1)
        
        let stopVC = StopWatchViewController()
        stopVC.tabBarItem = UITabBarItem(title: "스탑워치", image: UIImage(systemName: "stopwatch.fill"), tag: 2)
        
        let wolrdVC = WorldClockViewController()
        wolrdVC.tabBarItem = UITabBarItem(title: "세계 시계", image: UIImage(systemName: "globe"), tag: 3)
        
        self.viewControllers = [alarmVC, timerVC, stopVC, wolrdVC]
        
        self.modalPresentationStyle = .fullScreen
        
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.tintColor = .orange
    }
}
