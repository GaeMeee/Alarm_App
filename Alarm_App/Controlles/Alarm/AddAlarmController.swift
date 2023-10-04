//
//  AddAlarmViewController.swift
//  practiceAlarm
//
//  Created by 김지훈 on 2023/10/03.
//

import UIKit
import SnapKit

class AddAlarmViewController: UIViewController {
    
    var pickedDate: ((_ date: Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(addAlarmNaviBar)
        addTimeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    lazy var addAlarmNaviBar: UINavigationBar = {
        let addAlarmNaviBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        
        let navigationItem = UINavigationItem(title: "알람 추가")
        
        addAlarmNaviBar.barTintColor = .black
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white // 흰색으로 설정
        ]
        addAlarmNaviBar.titleTextAttributes = titleAttributes
        
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(doCancel))
        cancelButton.tintColor = .systemOrange
        navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(doSave))
        saveButton.tintColor = .systemOrange
        navigationItem.rightBarButtonItem = saveButton
        
        addAlarmNaviBar.items = [navigationItem]
        return addAlarmNaviBar
    }()
    
    @objc func doCancel() {
        print("--> do cancel!")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func doSave() {
        print("--> do doSave!")
        pickedDate?(timePickerView.date)
        print("--> 선택한 시간: \(timePickerView.date)")
        self.dismiss(animated: true, completion: nil)
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    lazy var timePickerView: UIDatePicker = {
        let timePickerView = UIDatePicker()
        timePickerView.preferredDatePickerStyle = .wheels
        timePickerView.datePickerMode = .time
        timePickerView.locale = NSLocale(localeIdentifier: "ko_KR") as Locale
        timePickerView.setValue(UIColor.white, forKey: "textColor")
        return timePickerView
    }()
    
    func addTimeUI() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(addAlarmNaviBar.snp.bottom).offset(100)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        view.addSubview(timePickerView)
        timePickerView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.centerY.equalTo(label)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }

}
