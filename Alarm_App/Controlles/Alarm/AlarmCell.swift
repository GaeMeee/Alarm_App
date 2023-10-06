//
//  AlarmCell.swift
//  practiceAlarm
//
//  Created by 김지훈 on 2023/10/03.
//

import UIKit
import SnapKit
import UserNotifications

class AlarmCell: UITableViewCell {
    
    static let identifier = "AlarmCell"
    private let notificationController = AppDelegate().notificationController
    
    lazy var timeCellStackView: UIStackView = {
        let timeCellStackView = UIStackView(arrangedSubviews: [ampmLabel, timeLabel])
        timeCellStackView.axis = .horizontal
        timeCellStackView.spacing = 5
        return timeCellStackView
    }()
    
    lazy var ampmLabel: UILabel = {
        let ampmLabel = UILabel()
        ampmLabel.font = .systemFont(ofSize: 28, weight: .light)
        ampmLabel.textColor = .white
        return ampmLabel
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = .systemFont(ofSize: 50, weight: .light)
        timeLabel.textColor = .white
        return timeLabel
    }()
    
    lazy var timeSwitchButton: UISwitch = {
        let timeSwitchButton = UISwitch()
        timeSwitchButton.addTarget(self, action: #selector(tapSwitchButton(sender:)), for: UIControl.Event.valueChanged)
        return timeSwitchButton
    }()
    
    @objc func tapSwitchButton(sender: UISwitch) {
        guard let data = UserDefaults.standard.value(forKey: "alarms") as? Data,
              var alarms = try? PropertyListDecoder().decode([Alarm].self, from: data) else { return }
        
        alarms[sender.tag].isOn = sender.isOn
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alarms), forKey: "alarms")
        let alarm = alarms[sender.tag]
        if sender.isOn {
            notificationController.notificationRegist(alarm)
        } else {
            notificationController.notificationRemove(alarm)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellPrint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellPrint() {
        contentView.addSubview(timeCellStackView)
        timeCellStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.leading.equalTo(self.contentView).offset(10)
        }
        
        contentView.addSubview(timeSwitchButton)
        timeSwitchButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.trailing.equalTo(self.contentView).offset(-10)
        }
        
    }

}
