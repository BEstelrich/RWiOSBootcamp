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
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var musicButton: UIButton!
  @IBOutlet weak var answersTableView: UITableView!
  
  private let jQuizGame = JQuizGame()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupView()
  }
  
  
  func setupView() {
    setLogoImageView()
    prepareViewForNextRound()
    updateSoundManagerSettings()
  }
  
  
  func setLogoImageView() {
    NetworkService.shared.downloadImage(from: Constants.URL.hearderImage) { (image) in
      DispatchQueue.main.async {
        self.logoImageView.image = image
      }
    }
  }
  
  
  func updateSoundManagerSettings() {
    musicButton.isSelected = AppSettings.isSoundEnabled ? false : true
    SoundManager.shared.updateSound()
  }
  
  
  func prepareViewForNextRound() {
    jQuizGame.setupGame {
      DispatchQueue.main.async {
        self.categoryLabel.text = self.jQuizGame.currentClue?.category?.title?.capitalized
        self.clueLabel.text = self.jQuizGame.currentClue?.question
        self.scoreLabel.text = "\(self.jQuizGame.points)"
        self.answersTableView.reloadData()
      }
    }
  }
  

  @IBAction func didPressVolumeButton(_ sender: UIButton) {
    AppSettings.isSoundEnabledToggle()
    updateSoundManagerSettings()
  }
  
  
  @IBAction func didPressResetButton(_ sender: UIButton) {
    jQuizGame.resetGame()
    prepareViewForNextRound()
  }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func setupTableView() {
    answersTableView.delegate = self
    answersTableView.dataSource = self
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return jQuizGame.clues.count
  }

  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = answersTableView.dequeueReusableCell(withIdentifier: AnswersTableViewCell.reuseIdentifier) as? AnswersTableViewCell else { return UITableViewCell() }
    let clue = jQuizGame.clues[indexPath.row]
    cell.populate(with: clue)
    return cell
  }
  
  
  func tableView(_ tableView: UITableView , didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! AnswersTableViewCell
    tableView.isUserInteractionEnabled = false
    let selectedAnswer = cell.answerLabel.text!.cleanHTMLAttributes!.capitalized
    jQuizGame.checkIfCorrect(selectedAnswer) ? cell.updateAppearance(to: .green) : cell.updateAppearance(to: .red)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      cell.updateAppearance(to: .systemPurple)
      self.prepareViewForNextRound()
      tableView.isUserInteractionEnabled = true
    }
  }
  
}
