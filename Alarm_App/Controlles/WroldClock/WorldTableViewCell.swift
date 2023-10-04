//
//  WorldTableViewCell.swift
//  Alarm_App
//
//  Created by JeonSangHyeok on 2023/09/25.
//

import UIKit

class WorldTableViewCell: UITableViewCell {
    
    static let identify: String = "worldCell"
    
    lazy var cityLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timeDifferenceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 50, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        setupUI()
    }
}

private extension WorldTableViewCell {
    func setupUI() {
        setupCityLabel()
        setupCurrentTimeLabel()
        setupTimeDifferenceLabel()
    }
    
    func setupCityLabel() {
        contentView.addSubview(cityLabel)
        
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cityLabel.widthAnchor.constraint(equalToConstant: 220),
            cityLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupCurrentTimeLabel() {
        contentView.addSubview(currentTimeLabel)
        
        NSLayoutConstraint.activate([
            currentTimeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            currentTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            currentTimeLabel.widthAnchor.constraint(equalToConstant: 130),
            currentTimeLabel.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    func setupTimeDifferenceLabel() {
        contentView.addSubview(timeDifferenceLabel)
        
        NSLayoutConstraint.activate([
            timeDifferenceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            timeDifferenceLabel.bottomAnchor.constraint(equalTo: cityLabel.topAnchor),
            timeDifferenceLabel.widthAnchor.constraint(equalToConstant: 100),
            timeDifferenceLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
