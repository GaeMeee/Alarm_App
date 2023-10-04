//
//  StopWatch.swift
//  Alarm_App
//
//  Created by hong on 2023/09/25.
//

import Foundation

struct StopwatchModel: Codable {
    var timeElapsed: Int // 단위: 초 (경과 시간)
    var lapTimes: [Int] // 단위: 초 
}
