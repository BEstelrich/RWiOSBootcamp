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
  
  var clues: [Clue] = [] { didSet { answersTableView.reloadData() } }
  var correctAnswerClue: Clue?
  var points: Int = 0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupTableView()
    getClues()
  }
  
  
  func setupView() {
    setLogoImageView()
    categoryLabel.text = clues.first?.category?.title?.capitalized
    clueLabel.text = clues.first?.question
    scoreLabel.text = "\(points)"
    updateSoundManager()
  }
  
  
  func setLogoImageView() {
    NetworkService.shared.downloadImage(from: Constants.URL.hearderImage) { (image) in
      DispatchQueue.main.async {
        self.logoImageView.image = image
      }
    }
  }
  
  
  func getClues() {
    NetworkService.shared.getRandomCategory(completion: { (clues, error) in
      guard let category = clues?.first?.category,
        error == nil else { return }
      
      NetworkService.shared.getAllCluesInCategory(category) { (clues, error) in
        guard let clues = clues,
          error == nil else { return }
        DispatchQueue.main.async {
          self.clues = clues
          self.setupView()
        }
      }
    })
  }
  
  func updateSoundManager() {
    musicButton.isSelected = AppSettings.isSoundEnabled ? false : true
    SoundManager.shared.updateSound()
  }
  
  
  @IBAction func didPressVolumeButton(_ sender: UIButton) {
    AppSettings.isSoundEnabledToggle()
    updateSoundManager()
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

