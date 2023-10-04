import UIKit

class StopwatchViewController: UIViewController {

   

    var timer: Timer?
    var isRunning = false
    var centiseconds = 0
    var lapTimes: [String] = []

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

 

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    

    @objc func updateTimer() {
        centiseconds += 1
        updateUI()
    }

    

    func updateUI() {
        let minutes = centiseconds / 6000
        let seconds = (centiseconds % 6000) / 100
        let centis = centiseconds % 100

        timeLabel.text = String(format: "%02d:%02d.%02d", minutes, seconds, centis)
    }

   

    func setupUI() {
        view.backgroundColor = .black

        view.addSubview(timeLabel)
        view.addSubview(startStopButton)
        view.addSubview(resetButton)
        view.addSubview(lapButton)
        view.addSubview(lapTableView)

        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),

            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // resetButton의 leading을 변경
            resetButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 120), // resetButton의 top을 변경
            resetButton.widthAnchor.constraint(equalToConstant: 100), // 너비를 100으로 설정
            resetButton.heightAnchor.constraint(equalToConstant: 100), // 높이를 100으로 설정

            startStopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // startStopButton의 trailing을 변경
            startStopButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 120), // startStopButton의 top을 변경
            startStopButton.widthAnchor.constraint(equalToConstant: 100), // 너비를 100으로 설정
            startStopButton.heightAnchor.constraint(equalToConstant: 100), // 높이를 100으로 설정

            lapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lapButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 20),
            lapButton.widthAnchor.constraint(equalToConstant: 100),
            lapButton.heightAnchor.constraint(equalToConstant: 100),

            lapTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lapTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lapTableView.topAnchor.constraint(equalTo: lapButton.bottomAnchor, constant: 20),
            lapTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])


        startStopButton.addTarget(self, action: #selector(startStopButtonPressed), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        lapButton.addTarget(self, action: #selector(lapButtonPressed), for: .touchUpInside)

        lapTableView.delegate = self
        lapTableView.dataSource = self
        lapTableView.register(UITableViewCell.self, forCellReuseIdentifier: "lapCell")
    }

    

    @objc func startStopButtonPressed() {
        if isRunning {
            timer?.invalidate()
            isRunning = false
            startStopButton.setTitle("시작", for: .normal)
            startStopButton.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 0.6, alpha: 1) // 초록색으로 변경
            lapButton.isHidden = true
        } else {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            isRunning = true
            startStopButton.setTitle("정지", for: .normal)
            startStopButton.backgroundColor = UIColor(red: 0.8, green: 0.4, blue: 0.4, alpha: 1) // 빨간색으로 변경
            lapButton.isHidden = false
        }
    }

    @objc func resetButtonPressed() {
        timer?.invalidate()
        centiseconds = 0
        updateUI()
        isRunning = false
        startStopButton.setTitle("시작", for: .normal)
        lapButton.isHidden = true
        lapTimes.removeAll()
        lapTableView.reloadData()
    }

    @objc func lapButtonPressed() {
        guard isRunning else { return }
        let lapTime = timeLabel.text ?? "00:00.00"
        lapTimes.append(lapTime)
        lapTableView.reloadData()
        
        
    }

}

extension StopwatchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTimes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lapCell", for: indexPath)
        cell.textLabel?.text = "Lap \(indexPath.row + 1): \(lapTimes[indexPath.row])"
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        return cell
    }
}
