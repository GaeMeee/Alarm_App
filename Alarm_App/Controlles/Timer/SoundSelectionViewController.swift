//
//  SoundSelectionViewController.swift
//  Alarm_App
//
//  Created by 김도윤 on 2023/09/28.
//
//
import AVFoundation
import UIKit

protocol SoundSelectionDelegate: AnyObject {
    func soundSelected(named soundName: String)
}

class SoundSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    weak var delegate: SoundSelectionDelegate?
    let tableView = UITableView()
    let sounds = ["전파탐지기", "도입음", "프레스토"]
    var selectedSoundIndex: Int?
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTableView()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "타이머 종료 시"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(confirmButtonTapped))
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sounds[indexPath.row]
        if indexPath.row == selectedSoundIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func confirmButtonTapped() {
        if let index = selectedSoundIndex {
            let soundNameWithoutExtension = sounds[index].replacingOccurrences(of: ".mp3", with: "")
            NotificationCenter.default.post(name: Notification.Name("SoundSelected"), object: soundNameWithoutExtension)
            delegate?.soundSelected(named: soundNameWithoutExtension)
        }
        audioPlayer?.stop()
        dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSoundIndex = indexPath.row
        tableView.reloadData()
        
        audioPlayer?.stop()
        
        let soundName = sounds[indexPath.row]
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
