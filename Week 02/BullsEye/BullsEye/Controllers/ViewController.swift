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
    return abs(game.targetValue - Int(slider.value.rounded()))
  }
  
  let game = BullsEyeGame()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    game.startNewGame()
    updateView()
  }
  
  
  @IBAction func sliderDidDrag(_ slider: UISlider) {
    addColorTintHint()
  }
  
  
  @IBAction func hitMeButtonDidTap() {
    game.calculateRoundResult(for: slider.value.rounded())
    
    let alert = UIAlertController(title: game.roundMessage,
                                  message: "You scored \(game.roundScore) points",
                                  preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default, handler: { action in
      self.game.startNewRound()
      self.updateView()
    })
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  
  @IBAction func startOverButtonDidTap() {
    game.startNewGame()
    updateView()
  }
  
  
  func updateView() {
    targetLabel.text = String(game.targetValue)
    scoreLabel.text = String(game.gameScore)
    roundLabel.text = String(game.roundNumber)
    slider.value = 50
    addColorTintHint()
  }
  
  
  func addColorTintHint() {
    slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDifference)/100.0)
  }
  
}
