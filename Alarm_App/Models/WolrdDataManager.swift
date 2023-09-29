//
//  WolrdDataManager.swift
//  Alarm_App
//
//  Created by JeonSangHyeok on 2023/09/25.
//

import Foundation

class WorldDataManager {
    static let shard = WorldDataManager()
    
    var worldDataList: [WorldClockModel] {
        getWorldList()
    }
    var selectedWolrdAbbreviation: [String] = []
    var selectedDataList: [WorldClockModel] {
        fetchSelectedWorldData(string: selectedWolrdAbbreviation)
    }
    
    func getWorldList() -> [WorldClockModel] {
        var worldList: [WorldClockModel] = []
        
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
            
            worldList.append(WorldClockModel(location: regionName, currentTime: currentTime, abbreveiation: tz))
        }
        
        worldList.sort { $0.location < $1.location }
        
        return worldList
    }
    
    func addSelectedWorldDataList(abbreviationString: String){
        selectedWolrdAbbreviation.append(abbreviationString)
    }
    
    func fetchSelectedWorldData(string: [String]) -> [WorldClockModel] {
        var dates: [WorldClockModel] = []
        for tz in string {
            guard let timezone = TimeZone(identifier: tz) else {continue}
            
            guard var regionName = timezone.localizedName(for: .shortGeneric, locale: Locale(identifier: "ko-KR")) else {continue}
            
            var date = regionName.split(separator: " ")
            let _ = date.popLast()
            regionName = date.joined(separator: " ")
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = timezone
            dateFormatter.dateFormat = "HH:mm"
            
            let selectedDate = WorldClockModel(location: regionName, currentTime: dateFormatter.string(from: Date()), abbreveiation: tz)
            
            dates.append(selectedDate)
        }
        return dates
    }
}
