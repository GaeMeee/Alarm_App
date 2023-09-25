//
//  WorldClock.swift
//  Alarm_App
//
//  Created by hong on 2023/09/25.
//

import Foundation

struct WorldClock: Codable {
    var location: String
    var timeDifference: Int // 단위: 시간 
}
