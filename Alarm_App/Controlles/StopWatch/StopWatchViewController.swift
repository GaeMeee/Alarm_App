
import UIKit

class StopwatchViewController: UIViewController {


    var timer: Timer?
    var isRunning = false
    var centiseconds = 0
    var lapTimes: [String] = []

 private let stopWatchView = StopWatchView()
    
    override func loadView() {
        view = stopWatchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupButtonAction()
    }

    

    @objc func updateTimer() {
        centiseconds += 1
        updateUI()
    }

    func setupButtonAction() {
        stopWatchView.startStopButton.addTarget(self, action: #selector(startStopButtonPressed), for: .touchUpInside)
        stopWatchView.resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        stopWatchView.lapButton.addTarget(self, action: #selector(lapButtonPressed), for: .touchUpInside)
        
    }
    
    func setupTableView() {
        stopWatchView.lapTableView.delegate = self
        stopWatchView.lapTableView.dataSource = self
        
    }
    

    func updateUI() {
        let minutes = centiseconds / 6000
        let seconds = (centiseconds % 6000) / 100
        let centis = centiseconds % 100

        stopWatchView.timeLabel.text = String(format: "%02d:%02d.%02d", minutes, seconds, centis)
    }

 
    @objc func startStopButtonPressed() {
        if isRunning {
            timer?.invalidate()
            isRunning = false
            stopWatchView.startStopButton.setTitle("시작", for: .normal)
            stopWatchView.startStopButton.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 0.6, alpha: 1) // 초록색으로 변경
            stopWatchView.lapButton.isHidden = true
        } else {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            isRunning = true
            stopWatchView.startStopButton.setTitle("정지", for: .normal)
            stopWatchView.startStopButton.backgroundColor = UIColor(red: 0.8, green: 0.4, blue: 0.4, alpha: 1) // 빨간색으로 변경
            stopWatchView.lapButton.isHidden = false
        }
    }

    @objc func resetButtonPressed() {
        timer?.invalidate()
        centiseconds = 0
        updateUI()
        isRunning = false
        stopWatchView.startStopButton.setTitle("시작", for: .normal)
        stopWatchView.lapButton.isHidden = true
        lapTimes.removeAll()
        stopWatchView.lapTableView.reloadData()
    }

    @objc func lapButtonPressed() {
        guard isRunning else { return }
        let lapTime = stopWatchView.timeLabel.text ?? "00:00.00"
        lapTimes.append(lapTime)
        stopWatchView.lapTableView.reloadData()
        
        
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
