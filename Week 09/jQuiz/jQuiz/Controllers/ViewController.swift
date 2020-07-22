//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
  
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var soundButton: UIButton!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var clueLabel: UILabel!
  @IBOutlet weak var answersTableView: UITableView!
  @IBOutlet weak var scoreLabel: UILabel!
  
  var clues: [Clue] = []
  var correctAnswerClue: Clue?
  var points: Int = 0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupView()
  }
  
  
  func setupView() {
    self.scoreLabel.text = "\(self.points)"
    
    if SoundManager.shared.isSoundEnabled == false {
      soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
    } else {
      soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
    }
    SoundManager.shared.playSound()
  }
  
  
  @IBAction func didPressVolumeButton(_ sender: UIButton) {
    SoundManager.shared.toggleSoundPreference()
    if SoundManager.shared.isSoundEnabled == false {
      soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
    } else {
      soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
    }
  }
  
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func setupTableView() {
    answersTableView.delegate = self
    answersTableView.dataSource = self
    answersTableView.separatorStyle = .none
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return clues.count
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return answersTableView.frame.height / 4
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = answersTableView.dequeueReusableCell(withIdentifier: AnswersTableViewCell.reuseIdentifier) as? AnswersTableViewCell else { return UITableViewCell() }
    let clue = clues[indexPath.row]
    cell.populate(with: clue)
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
}

