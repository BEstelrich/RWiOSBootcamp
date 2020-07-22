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
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var clueLabel: UILabel!
  @IBOutlet weak var answersTableView: UITableView!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var soundButton: UIButton!
  
  var clues: [Clue] = []
  var correctAnswerClue: Clue?
  var points: Int = 0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupTableView()
    getClues()
  }
  
  
  func setupView() {
    self.scoreLabel.text = "\(self.points)"
    self.categoryLabel.text = clues.first?.category?.title?.capitalized
    self.clueLabel.text = clues.first?.question?.capitalized
    
    self.answersTableView.reloadData()
    
    if SoundManager.shared.isSoundEnabled == false {
      soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
    } else {
      soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
    }
    SoundManager.shared.playSound()
  }
  
  
  func getClues() {
    Networking.shared.getRandomCategory(completion: { (clues, error) in
      guard let category = clues?.first?.category,
        error == nil else { return }
      
      Networking.shared.getAllCluesInCategory(category) { (clues, error) in
        guard let clues = clues,
          error == nil else { return }
        DispatchQueue.main.async {
          self.clues = clues
          self.setupView()
        }
      }
    })
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
//    return answersTableView.frame.height / 4
    return UITableView.automaticDimension
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

