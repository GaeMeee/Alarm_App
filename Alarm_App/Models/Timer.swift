//
//  Timer.swift
//  Alarm_App
//
//  Created by hong on 2023/09/25.
//

import Foundation

struct TimerModel: Codable {
    var timerTime: Int // 단위: 초
    var remainingTime: Int // 단위: 초
}
