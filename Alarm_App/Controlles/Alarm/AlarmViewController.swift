//
//  AlarmViewController.swift
//  Alarm_App
//
//  Created by JeonSangHyeok on 2023/09/25.
//

import UIKit
import SnapKit
import UserNotifications

class AlarmViewController: UIViewController {
    
    private var alarms: [Alarm] = []
    private let notificationController = AppDelegate().notificationController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationUI()
        alarmTableViewUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        alarms = alarmList()
    }
    
    lazy var plusButton: UIBarButtonItem = {
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(goToAddPage))
        plusButton.tintColor = .systemOrange
        return plusButton
    }()
    
    @objc func goToAddPage() {
        print("--> go to AddPage")
        let addAlarmViewController = AddAlarmViewController()
        
        addAlarmViewController.pickedDate = {[weak self] date in
            guard let self = self else { return }
            
            var alarmList = self.alarmList()
            let newAlarm = Alarm(setTime: date, date: date, isOn: true)
            
            alarmList.append(newAlarm)
            self.alarms = alarmList
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alarms), forKey: "alarms")
            
            notificationController.notificationRegist(newAlarm)
            
            self.alarmListTableView.reloadData()
        }
        
        self.present(addAlarmViewController, animated: true, completion: nil)
    }
     
    lazy var alarmListTableView: UITableView = {
        let alarmListTableView = UITableView()
        alarmListTableView.dataSource = self
        alarmListTableView.delegate = self
        alarmListTableView.register(AlarmCell.self, forCellReuseIdentifier: "AlarmCell")
        alarmListTableView.backgroundColor = .black
        return alarmListTableView
    }()
    
    func navigationUI() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
        ]
        
        navigationItem.title = "알람"
        self.navigationItem.rightBarButtonItem = self.plusButton
    }
    
    func alarmTableViewUI() {
        view.addSubview(alarmListTableView)
        alarmListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func alarmList() -> [Alarm] {
        guard let data = UserDefaults.standard.value(forKey: "alarms") as? Data,
              let alarms = try? PropertyListDecoder().decode([Alarm].self, from: data) else { return [] }
        return alarms
    }
    
}

extension AlarmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlarmCell.identifier, for: indexPath) as! AlarmCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        
        cell.ampmLabel.text = alarms[indexPath.row].meridiem
        cell.timeLabel.text = alarms[indexPath.row].time
        cell.timeSwitchButton.isOn = alarms[indexPath.row].isOn
        
        cell.timeSwitchButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //셀 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case.delete:
            let alarm = alarms[indexPath.row]
            self.alarms.remove(at: indexPath.row)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alarms), forKey: "alarms")
            notificationController.notificationRemove(alarm)
            alarmListTableView.reloadData()
            return
        default:
            break
        }
    }
    
}
