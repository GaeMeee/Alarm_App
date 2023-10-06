import UIKit

class StopWatchView: UIView {

   
    // UI

      let timeLabel: UILabel = {
          let label = UILabel()
          label.font = UIFont.systemFont(ofSize: 80, weight: .thin) // 더 얇은 폰트로 변경
          label.text = "00:00.00"
          label.textColor = .white
          label.textAlignment = .center
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()

      
      let startStopButton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("시작", for: .normal)
          button.setTitleColor(.white, for: .normal)
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
          button.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 0.6, alpha: 1)
          button.layer.cornerRadius = 50
          
          
          button.translatesAutoresizingMaskIntoConstraints = false
          return button
      }()

      let resetButton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("재설정", for: .normal)
          button.setTitleColor(.white, for: .normal)
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
          button.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
          button.layer.cornerRadius = 50
          button.translatesAutoresizingMaskIntoConstraints = false
          return button
      }()

      let lapButton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("랩", for: .normal)
          button.setTitleColor(.white, for: .normal)
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
          button.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
          button.layer.cornerRadius = 50
          button.isHidden = true
          button.translatesAutoresizingMaskIntoConstraints = false
          return button
      }()

      let lapTableView: UITableView = {
          let tableView = UITableView()
          tableView.backgroundColor = .black
          tableView.translatesAutoresizingMaskIntoConstraints = false
          return tableView
      }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        lapTableView.register(UITableViewCell.self, forCellReuseIdentifier: "lapCell")
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        

    }
    
}

extension StopWatchView {
    
    func setupUI() {
        self.backgroundColor = .black

        self.addSubview(timeLabel)
        self.addSubview(startStopButton)
        self.addSubview(resetButton)
        self.addSubview(lapButton)
        self.addSubview(lapTableView)

        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 170),

            resetButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20), // resetButton의 leading을 변경
            resetButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 120), // resetButton의 top을 변경
            resetButton.widthAnchor.constraint(equalToConstant: 100), // 너비를 100으로 설정
            resetButton.heightAnchor.constraint(equalToConstant: 100), // 높이를 100으로 설정

            startStopButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20), // startStopButton의 trailing을 변경
            startStopButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 120), // startStopButton의 top을 변경
            startStopButton.widthAnchor.constraint(equalToConstant: 100), // 너비를 100으로 설정
            startStopButton.heightAnchor.constraint(equalToConstant: 100), // 높이를 100으로 설정

            lapButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            lapButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 20),
            lapButton.widthAnchor.constraint(equalToConstant: 100),
            lapButton.heightAnchor.constraint(equalToConstant: 100),

            lapTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lapTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lapTableView.topAnchor.constraint(equalTo: lapButton.bottomAnchor, constant: 20),
            lapTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])


     
       
    }

    
}
