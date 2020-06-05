//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//
import UIKit


class ViewController: UIViewController {
  
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  
  var quickDifference: Int {
    return abs(gameLogic.targetValue - Int(slider.value.rounded()))
  }
  
  let gameLogic = BullsEyeGame()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    gameLogic.startNewGame()
    updateView()
  }
  
  
  @IBAction func hitMeButtonDidTap() {
    gameLogic.calculateRoundResult(for: slider.value.rounded())
    
    let alert = UIAlertController(title: gameLogic.roundMessage,
                                  message: "You scored \(gameLogic.roundScore) points",
                                  preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default, handler: { action in
      self.gameLogic.startNewRound()
      self.updateView()
    })
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }
  
  
  @IBAction func sliderDidDrag(_ slider: UISlider) {
    addColorTintHint()
  }
  
  
  @IBAction func startOverButtonDidTap() {
    gameLogic.startNewGame()
    updateView()
  }
  
  
  func updateView() {
    targetLabel.text = String(gameLogic.targetValue)
    scoreLabel.text = String(gameLogic.gameScore)
    roundLabel.text = String(gameLogic.roundNumber)
    slider.value = 50
    addColorTintHint()
  }
  
  
  func addColorTintHint() {
    slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDifference)/100.0)
  }
  
}
