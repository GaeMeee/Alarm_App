//
//  TimerViewController.swift
//  Alarm_App
//
//  Created by JeonSangHyeok on 2023/09/25.
//

import AVFoundation
import UIKit

class TimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let timerView = TimerView()
    var timer: Foundation.Timer?
    var remainingTime: Int = 0
    var selectedSoundName: String?
    var audioPlayer: AVAudioPlayer?
    
    override func loadView() {
        view = timerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(soundSelected(_:)), name: Notification.Name("SoundSelected"), object: nil)

        timerView.hourPickerView.delegate = self
        timerView.hourPickerView.dataSource = self
        timerView.minutePickerView.delegate = self
        timerView.minutePickerView.dataSource = self
        timerView.secondPickerView.delegate = self
        timerView.secondPickerView.dataSource = self
        
        timerView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        timerView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        timerView.soundSelectionButton.addTarget(self, action: #selector(soundSelectionButtonTapped), for: .touchUpInside)
        timerView.pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        setupAudioSession()
        timerView.stopSoundButton.addTarget(self, action: #selector(stopSoundButtonTapped), for: .touchUpInside)
    }
    
    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == timerView.hourPickerView {
            return 24
        } else {
            return 60
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    @objc func startButtonTapped() {
        let hour = timerView.hourPickerView.selectedRow(inComponent: 0)
        let minute = timerView.minutePickerView.selectedRow(inComponent: 0)
        let second = timerView.secondPickerView.selectedRow(inComponent: 0)
        
        remainingTime = hour * 3600 + minute * 60 + second
        
        if remainingTime > 0 {
            timerView.startButton.isHidden = true
            timerView.pauseButton.isHidden = false
            timerView.timeLabel.isHidden = false
            timerView.hourPickerView.isHidden = true
            timerView.minutePickerView.isHidden = true
            timerView.secondPickerView.isHidden = true
            timerView.hourLabel.isHidden = true
            timerView.minuteLabel.isHidden = true
            timerView.secondLabel.isHidden = true
            
            timerView.pauseButton.backgroundColor = .yellow
            timerView.timeLabel.text = String(format: "%02d:%02d:%02d", hour, minute, second)
            
            timer?.invalidate()
            timer = Foundation.Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: .common)
        }
    }

    @objc func soundSelected(_ notification: Notification) {
        if let soundName = notification.object as? String {
            print("Sound Selected: \(soundName)")
            timerView.soundSelectionButton.rightLabel.text = soundName
            selectedSoundName = soundName
        }
    }

    func playSound() {
        guard let soundName = selectedSoundName,
              let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        else {
            print("Error: Selected sound name not found or invalid")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing the audio file: \(error.localizedDescription)")
        }
    }

    func timerFinished() {
        playSound()
    }

    @objc func updateTime() {
        if remainingTime > 0 {
            remainingTime -= 1
            let hour = remainingTime / 3600
            let minute = (remainingTime % 3600) / 60
            let second = remainingTime % 60
            timerView.timeLabel.text = String(format: "%02d:%02d:%02d", hour, minute, second)
        } else {
            print("Timer Finished")
            resetTimer()
            playSound()
            timerView.stopSoundButton.isHidden = false
        }
    }

    @objc func stopSoundButtonTapped() {
        audioPlayer?.stop()
        timerView.stopSoundButton.isHidden = true
    }
    
    @objc func pauseButtonTapped() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
            timerView.pauseButton.setTitle("재개", for: .normal)
            timerView.pauseButton.backgroundColor = .green
            timerView.pauseButton.setTitleColor(.black, for: .normal)
        } else {
            let hour = remainingTime / 3600
            let minute = (remainingTime % 3600) / 60
            let second = remainingTime % 60
            timerView.timeLabel.text = String(format: "%02d:%02d:%02d", hour, minute, second)
            timer = Foundation.Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            timerView.pauseButton.setTitle("일시정지", for: .normal)
            timerView.pauseButton.backgroundColor = .yellow
            timerView.pauseButton.setTitleColor(.black, for: .normal)
        }
    }
    
    @objc func cancelButtonTapped() {
        resetTimer()
    }
    
    func resetTimer() {
        timerView.startButton.isHidden = false
        timerView.pauseButton.isHidden = true
        timer?.invalidate()
        timer = nil
        timerView.hourPickerView.isHidden = false
        timerView.minutePickerView.isHidden = false
        timerView.secondPickerView.isHidden = false
        timerView.hourLabel.isHidden = false
        timerView.minuteLabel.isHidden = false
        timerView.secondLabel.isHidden = false
        timerView.timeLabel.isHidden = true
        timerView.stopSoundButton.isHidden = true
    }
    
    @objc func soundSelectionButtonTapped() {
        let soundSelectionVC = SoundSelectionViewController()
        soundSelectionVC.delegate = self
        let navController = UINavigationController(rootViewController: soundSelectionVC)
        navController.modalPresentationStyle = .overCurrentContext
        present(navController, animated: true, completion: nil)
    }
}

extension TimerViewController: SoundSelectionDelegate {
    func soundSelected(named soundName: String) {
        selectedSoundName = soundName
        timerView.soundSelectionButton.rightLabel.text = soundName
    }
}
