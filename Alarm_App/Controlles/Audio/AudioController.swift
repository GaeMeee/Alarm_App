//
//  AudioController.swift
//  Alarm_App
//
//  Created by hong on 2023/09/26.
//

import Foundation
import AVFoundation

final class AudioController: NSObject {
    private var audioPlayer: AVAudioPlayer?
    
    func prepare(_ audioFile: String) {
        do {
            guard let audioURL = Bundle.main.url(forResource: audioFile, withExtension: "mp3") else {
                print("url error")
                return
            }
            print(audioURL)
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.prepareToPlay()
        } catch {
            print(error)
        }
    }
    
    func play() {
        audioPlayer?.play()
    }
    
    func stop() {
        audioPlayer?.stop()
    }
}

extension AudioController: AVAudioPlayerDelegate {
    
}
