//
//  WorldView.swift
//  Alarm_App
//
//  Created by JeonSangHyeok on 2023/09/25.
//

import UIKit

class WorldView: UIView {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .black
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupTableView()
        super.updateConstraints()
    }
}

private extension WorldView {
    func setupUi() {
        
    }
    
    func setupTableView() {
        self.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
