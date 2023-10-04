//
//  WorldClock.swift
//  Alarm_App
//
//  Created by hong on 2023/09/25.
//

import Foundation

struct WorldClock: Codable {
    var location: String
    var currentTime: String // 단위: 시간
    var abbreveiation: String
}
