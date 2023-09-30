//
//  WorldListViewController.swift
//  Alarm_App
//
//  Created by JeonSangHyeok on 2023/09/25.
//

import UIKit

protocol WorldListVCDelegate: AnyObject {
    func addSelectedWorldData(worldData: WorldClockModel)
    func currentSecondInt(int: Int)
}

class WorldListViewController: UIViewController {
    
    weak var delegate: WorldListVCDelegate?
    
    private let worldDataManager: WorldDataManager
    
    private let worldListView = WorldListView()
    
    init(worldDataManager: WorldDataManager) {
        self.worldDataManager = worldDataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = worldListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupButtonAction()
    }
    
    private func setupTableView() {
        worldListView.tableView.dataSource = self
        worldListView.tableView.delegate = self
    }
    
    private func setupButtonAction() {
        worldListView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
}

extension WorldListViewController {
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
}

extension WorldListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worldDataManager.worldDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let worldData = worldDataManager.worldDataList[indexPath.row]
        
        cell.textLabel?.text = worldData.location
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
}

extension WorldListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = worldDataManager.worldDataList[indexPath.row]
        delegate?.addSelectedWorldData(worldData: selectedData)
        delegate?.currentSecondInt(int: Calendar.current.component(.second, from: Date()))
        dismiss(animated: true)
    }
}
