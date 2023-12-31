//
//  TimerView.swift
//  Alarm_App
//
//  Created by 김도윤 on 2023/09/25.
//

import AVFoundation
import UIKit

class TimerView: UIView {
    let hourPickerView = UIPickerView()
    let minutePickerView = UIPickerView()
    let secondPickerView = UIPickerView()
    
    let hourLabel = UILabel()
    let minuteLabel = UILabel()
    let secondLabel = UILabel()
    
    let startButton = UIButton()
    let cancelButton = UIButton()
    let pauseButton = UIButton()
    
    let soundSelectionButton = DualLabelButton()
    let stopSoundButton = UIButton()
    let timerLabel = UILabel()
    let timeLabel = UILabel()
    var timer: Timer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupTimerLabel()
        setupPickerStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupTimerLabel()
        setupPickerStyles()
    }

    private func setupPickerStyles() {
        [hourPickerView, minutePickerView, secondPickerView].forEach {
            $0.backgroundColor = .black
            $0.setValue(UIColor.white, forKeyPath: "textColor")
        }
    }
    
    private func setupViews() {
        backgroundColor = .black
        
        hourLabel.text = "시간"
        minuteLabel.text = "분"
        secondLabel.text = "초"
        
        [hourLabel, minuteLabel, secondLabel].forEach {
            $0.font = .systemFont(ofSize: 20)
            $0.textColor = .white
        }
        
        let hourStack = createHorizontalStackView(pickerView: hourPickerView, label: hourLabel, labelWidth: 40)
        let minuteStack = createHorizontalStackView(pickerView: minutePickerView, label: minuteLabel, labelWidth: 20)
        let secondStack = createHorizontalStackView(pickerView: secondPickerView, label: secondLabel, labelWidth: 20)
        
        let pickerStackView = UIStackView(arrangedSubviews: [hourStack, minuteStack, secondStack])
        pickerStackView.axis = .horizontal
        pickerStackView.distribution = .fillEqually
        pickerStackView.spacing = 5
        pickerStackView.backgroundColor = .black
        
        timeLabel.textAlignment = .center
        timeLabel.isHidden = true
        timeLabel.textColor = .white
        
        addSubview(pickerStackView)
        pickerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            pickerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerStackView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        startButton.setTitle("시작", for: .normal)
        startButton.backgroundColor = .green
        startButton.setTitleColor(.black, for: .normal)
        
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.backgroundColor = .systemGray
        cancelButton.setTitleColor(.black, for: .normal)

        let buttonSize: CGFloat = 70
        
        startButton.layer.cornerRadius = buttonSize / 2
        cancelButton.layer.cornerRadius = buttonSize / 2
        
        startButton.clipsToBounds = true
        cancelButton.clipsToBounds = true
        
        pauseButton.setTitle("일시정지", for: .normal)
        pauseButton.setTitleColor(.black, for: .normal)
        pauseButton.backgroundColor = .systemGray
        pauseButton.layer.cornerRadius = 35
        pauseButton.isHidden = true
        
        let buttonStackView = UIStackView(arrangedSubviews: [cancelButton, startButton, pauseButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .equalSpacing
        buttonStackView.spacing = 200
        
        addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: pickerStackView.bottomAnchor, constant: 40),
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: buttonSize),
            startButton.widthAnchor.constraint(equalToConstant: buttonSize),
            cancelButton.widthAnchor.constraint(equalToConstant: buttonSize),
            pauseButton.widthAnchor.constraint(equalToConstant: buttonSize),
            pauseButton.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
        
        soundSelectionButton.setTitle("타이머 종료 시", for: .normal)
        soundSelectionButton.setTitleColor(.black, for: .normal)
        soundSelectionButton.backgroundColor = .systemGray
        soundSelectionButton.layer.cornerRadius = 25
        soundSelectionButton.contentHorizontalAlignment = .left
        soundSelectionButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        addSubview(soundSelectionButton)
        soundSelectionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            soundSelectionButton.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 40),
            soundSelectionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            soundSelectionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            soundSelectionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        stopSoundButton.setTitle("벨소리 중단", for: .normal)
        stopSoundButton.setTitleColor(.black, for: .normal)
        stopSoundButton.backgroundColor = .systemGray
        stopSoundButton.layer.cornerRadius = 25
        stopSoundButton.contentHorizontalAlignment = .center
        stopSoundButton.isHidden = true

        addSubview(stopSoundButton)
        stopSoundButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopSoundButton.topAnchor.constraint(equalTo: soundSelectionButton.bottomAnchor, constant: 20),
            stopSoundButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            stopSoundButton.widthAnchor.constraint(equalTo: soundSelectionButton.widthAnchor),
            stopSoundButton.heightAnchor.constraint(equalTo: soundSelectionButton.heightAnchor)
        ])
    }
    
    private func setupTimerLabel() {
        timeLabel.isHidden = true
        timeLabel.font = .systemFont(ofSize: 40)
        timeLabel.textAlignment = .center
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

private func createHorizontalStackView(pickerView: UIPickerView, label: UILabel, labelWidth: CGFloat) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: [pickerView, label])
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 5
        
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        label.widthAnchor.constraint(equalToConstant: labelWidth)
    ])
        
    return stackView
}
