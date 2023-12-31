//
//  WolrdDataManager.swift
//  Alarm_App
//
//  Created by JeonSangHyeok on 2023/09/25.
//

import Foundation

class WorldDataManager {
    static let shard = WorldDataManager()
    
    var worldDataList: [WorldClock] {
        getWorldList()
    }
    var selectedWolrdAbbreviation: [String] = []
    
    var selectedDataList: [WorldClock] {
        fetchSelectedWorldData(string: selectedWolrdAbbreviation)
    }
    
    func getWorldList() -> [WorldClock] {
        var worldList: [WorldClock] = []
        
        for tz in TimeZone.knownTimeZoneIdentifiers {
            guard let timezone = TimeZone(identifier: tz) else { continue }
            
            guard var regionName = timezone.localizedName(for: .shortGeneric, locale: Locale(identifier: "ko-KR")) else { continue }
            
            var data = regionName.split(separator: " ")
            let _ = data.popLast()
            
            regionName = data.joined(separator: " ")
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = timezone
            dateFormatter.dateFormat = "HH:mm"
            
            let currentTime = dateFormatter.string(from: Date())
            
            worldList.append(WorldClock(location: regionName, currentTime: currentTime, abbreveiation: tz))
        }
        
        worldList.sort { $0.location < $1.location }
        
        return worldList
    }
    
    func addSelectedWorldDataList(abbreviationString: String){
        selectedWolrdAbbreviation.append(abbreviationString)
    }
    
    func fetchSelectedWorldData(string: [String]) -> [WorldClock] {
        var dates: [WorldClock] = []
        for tz in string {
            guard let timezone = TimeZone(identifier: tz) else {continue}
            
            guard var regionName = timezone.localizedName(for: .shortGeneric, locale: Locale(identifier: "ko-KR")) else {continue}
            
            var date = regionName.split(separator: " ")
            let _ = date.popLast()
            
            regionName = date.joined(separator: " ")
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = timezone
            dateFormatter.dateFormat = "HH:mm"
            
            let selectedDate = WorldClock(location: regionName, currentTime: dateFormatter.string(from: Date()), abbreveiation: tz)
            
            dates.append(selectedDate)
        }
        return dates
    }
    
    func getTimeDifference(fromAbbreviation abbreviation: String) -> TimeInterval? {
        guard let seoulTimeZone = TimeZone(identifier: "Asia/Seoul"),
              let selectedTimeZone = TimeZone(identifier: abbreviation) else {
            return nil
        }
        
        let currentTime = Date()
        let seoulOffset = seoulTimeZone.secondsFromGMT(for: currentTime)
        let selectedOffset = selectedTimeZone.secondsFromGMT(for: currentTime)
        
        return TimeInterval(selectedOffset - seoulOffset)
    }
    
    func deleteSelectedWorld(index: Int) {
        if index < self.selectedDataList.count {
            self.selectedWolrdAbbreviation.remove(at: index)
        }
    }
}
