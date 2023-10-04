//
//  WorldClockViewController.swift
//  Alarm_App
//
//  Created by JeonSangHyeok on 2023/09/25.
//

import UIKit

class WorldClockViewController: UIViewController {
    
    private let worldView = WorldView()
    
    private let worldDataManager = WorldDataManager.shard
    
    private var currentSecond: Int = 0
    private var restSecond = 0
    private var updateTimer: Timer?
    
    override func loadView() {
        view = worldView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
        setupTableView()
    }
    
    func setupTableView() {
        worldView.tableView.dataSource = self
        worldView.tableView.delegate = self
        worldView.tableView.register(WorldTableViewCell.self, forCellReuseIdentifier: WorldTableViewCell.identify)
    }
    
    func setNav() {
        self.title = "세계 시계"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.backgroundColor = .clear
        
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(addButtonTapped))
    }
    
    func updateTableCell(cell: WorldTableViewCell, indexPath: IndexPath) {
        let worldDateArray = self.worldDataManager.selectedDataList
        if indexPath.row < worldDateArray.count {
            let worldData = worldDateArray[indexPath.row]
            cell.cityLabel.text = worldData.location
            cell.currentTimeLabel.text = worldData.currentTime
            
            let seoulTimeZone = TimeZone(identifier: "Asia/Seoul")!
            
            let selectedTimeZone = TimeZone(identifier: worldData.abbreveiation)
            
            if let selectedTimeZone = selectedTimeZone {
                let currentTime = Date()
                let seoulOffset = seoulTimeZone.secondsFromGMT(for: currentTime)
                let selectedOffset = selectedTimeZone.secondsFromGMT(for: currentTime)
                let timeDifferenceInHours = (selectedOffset - seoulOffset) / 3600
                
                var timeDifferenceType: String
                if timeDifferenceInHours == 0 {
                    timeDifferenceType = "0시간"
                } else {
                    let sign = timeDifferenceInHours > 0 ? "+" : "-"
                    let hours = abs(timeDifferenceInHours)
                    timeDifferenceType = "\(sign)\(hours)시간"
                }
                
                if Calendar.current.isDate(currentTime, inSameDayAs: currentTime.addingTimeInterval(TimeInterval(timeDifferenceInHours * 3600))) {
                    timeDifferenceType = "오늘, " + timeDifferenceType
                } else if Calendar.current.isDate(currentTime.addingTimeInterval(86400), inSameDayAs: currentTime.addingTimeInterval(TimeInterval(timeDifferenceInHours * 3600))) {
                    timeDifferenceType = "내일, " + timeDifferenceType
                } else if Calendar.current.isDate(currentTime.addingTimeInterval(-86400), inSameDayAs: currentTime.addingTimeInterval(TimeInterval(timeDifferenceInHours * 3600))) {
                    timeDifferenceType = "어제, " + timeDifferenceType
                }
                
                cell.timeDifferenceLabel.text = timeDifferenceType
            } else {
                cell.timeDifferenceLabel.text = "N/A"
            }
        } else {
            cell.cityLabel.text = "N/A"
            cell.currentTimeLabel.text = "N/A"
            cell.timeDifferenceLabel.text = "N/A"
        }
    }
}


extension WorldClockViewController {
    @objc func addButtonTapped() {
        let worldListVC = WorldListViewController(worldDataManager: worldDataManager)
        worldListVC.delegate = self
        self.present(worldListVC, animated: true)
    }
}

extension WorldClockViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worldDataManager.selectedWolrdAbbreviation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = worldView.tableView.dequeueReusableCell(withIdentifier: WorldTableViewCell.identify, for: indexPath) as! WorldTableViewCell
        cell.backgroundColor = .clear
        
        if restSecond != 0 {
            updateTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(restSecond), repeats: false) { [weak self] _ in
                self?.updateTableCell(cell: cell, indexPath: indexPath)
            }
            updateTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
                self?.updateTableCell(cell: cell, indexPath: indexPath)
            }
            
        } else {
            updateTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
                self?.updateTableCell(cell: cell, indexPath: indexPath)
            }
        }
        
        updateTableCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (_, _, completionHandler) in
            self?.worldDataManager.deleteSelectedWorld(index: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeConfig
    }
}


extension WorldClockViewController: WorldListVCDelegate {
    func addSelectedWorldData(worldData: WorldClock) {
        worldDataManager.selectedWolrdAbbreviation.append(worldData.abbreveiation)
        worldView.tableView.reloadData()
    }
    func currentSecondInt(int: Int) {
        self.currentSecond = int
        if 60 > currentSecond {
            restSecond = 60 - currentSecond
        } else {
            restSecond = 0
        }
    }
}
