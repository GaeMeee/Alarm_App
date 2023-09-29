//
//  WorldListView.swift
//  Alarm_App
//
//  Created by JeonSangHyeok on 2023/09/25.
//

import UIKit

class WorldListView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "도시 선택"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2274505198, green: 0.2274511456, blue: 0.2392150164, alpha: 1)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = #colorLiteral(red: 0.6549009681, green: 0.6549023986, blue: 0.68235147, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "검색", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        return tf
    }()
    
    lazy var cancelButton: UIButton = {
       let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension WorldListView {
    func setupUI() {
        self.backgroundColor = #colorLiteral(red: 0.1098035946, green: 0.1098040119, blue: 0.1176466122, alpha: 1)
        
        setupTitleLabel()
        setupSearchView()
        setupCancelButton()
        setupTableView()
    }
    
    func setupTitleLabel() {
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: 100),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupSearchView() {
        self.addSubview(searchView)

        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            searchView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            searchView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -55),
            searchView.heightAnchor.constraint(equalToConstant: 40)
        ])

        setupSearchImageView()
        setupSearchTextField()
    }

    func setupSearchImageView() {
        searchView.addSubview(searchImageView)

        NSLayoutConstraint.activate([
            searchImageView.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchImageView.centerXAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 20),
            searchImageView.widthAnchor.constraint(equalToConstant: 25),
            searchImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    func setupSearchTextField() {
        searchView.addSubview(searchTextField)

        NSLayoutConstraint.activate([
            searchTextField.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: 3),
            searchTextField.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -3),
            searchTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
    }

    func setupCancelButton() {
        self.addSubview(cancelButton)

        NSLayoutConstraint.activate([
            cancelButton.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: 5),
            cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }

    func setupTableView() {
        self.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }


}
