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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "편집", style: .done, target: self, action: #selector(editButtonTapped))
    }
    
    func updateTableCell(cell: WorldTableViewCell, indexPath: IndexPath) {
        let worldDateArray = self.worldDataManager.selectedDataList
        if indexPath.row < worldDateArray.count {
            let worldData = worldDateArray[indexPath.row]
            cell.cityLabel.text = worldData.location
            cell.currentTimeLabel.text = worldData.currentTime
        } else {
            cell.cityLabel.text = "N/A"
            cell.currentTimeLabel.text = "N/A"
        }
    }
}


extension WorldClockViewController {
    @objc func addButtonTapped() {
        let worldListVC = WorldListViewController(worldDataManager: worldDataManager)
        worldListVC.delegate = self
        self.present(worldListVC, animated: true)
    }
    
    @objc func editButtonTapped() {
        print("클릭")
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
        return 100
    }
}


extension WorldClockViewController: WorldListVCDelegate {
    func addSelectedWorldData(worldData: WorldClockModel) {
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
