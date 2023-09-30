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
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
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
    }
    
    func setupCityLabel() {
        contentView.addSubview(cityLabel)
        
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10),
            cityLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupCurrentTimeLabel() {
        contentView.addSubview(currentTimeLabel)
        
        NSLayoutConstraint.activate([
            currentTimeLabel.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor),
            currentTimeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            currentTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            currentTimeLabel.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
}
