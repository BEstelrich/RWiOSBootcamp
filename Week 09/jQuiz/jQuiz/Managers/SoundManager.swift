//
//  SoundManager.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
import AVFoundation

class SoundManager: NSObject {
  
  static let shared = SoundManager()
  private var player: AVAudioPlayer?
  
  
  private func playSound() {
    let path = Bundle.main.path(forResource: "JeopardyThemeSong.mp3", ofType:nil)!
    let url = URL(fileURLWithPath: path)
    
    do {
      player = try AVAudioPlayer(contentsOf: url)
      player?.play()
      player?.numberOfLoops = -1
      AppSettings.isSoundEnabled = true
    } catch let error as NSError {
      print("Error: \(error.description)")
    }
  }
  
  
  private func pauseSound() {
    player?.pause()
    AppSettings.isSoundEnabled = false
  }
  
  
  func updateSound() {
    AppSettings.isSoundEnabled ? playSound() : pauseSound()
  }
  
}
