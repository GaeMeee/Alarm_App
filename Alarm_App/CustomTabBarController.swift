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
        let alarmTabBarItem = UITabBarItem(title: "알람", image: UIImage(systemName: "alarm.fill"), tag: 0)
        let alarmNavigationController = UINavigationController(rootViewController: alarmVC)
        alarmNavigationController.tabBarItem = alarmTabBarItem
        
        let timerVC = TimerViewController()
        let timerTabBarItem = UITabBarItem(title: "타이머", image: UIImage(systemName: "timer"), tag: 1)
        let timerNavigationController = UINavigationController(rootViewController: alarmVC)
        timerNavigationController.tabBarItem = timerTabBarItem

        let stopVC = StopWatchViewController()
        let stopTabBarItem = UITabBarItem(title: "스탑워치", image: UIImage(systemName: "stopwatch.fill"), tag: 2)
        let stopNavigationController = UINavigationController(rootViewController: alarmVC)
        stopNavigationController.tabBarItem = stopTabBarItem

        
        let worldVC = WorldClockViewController()
        let worldTabBarItem = UITabBarItem(title: "세계 시계", image: UIImage(systemName: "globe"), tag: 3)
        let worldNavigationCoontroller = UINavigationController(rootViewController: worldVC)
        worldNavigationCoontroller.tabBarItem = worldTabBarItem
        
        self.viewControllers = [alarmNavigationController, timerNavigationController, stopNavigationController, worldNavigationCoontroller]
                
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.tintColor = .orange
    }
}
