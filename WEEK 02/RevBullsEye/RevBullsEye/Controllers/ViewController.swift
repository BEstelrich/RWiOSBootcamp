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
  @IBOutlet weak var userTextField: UITextField!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  
//  var quickDifference: Int {
//    return abs(game.targetValue - Int(userGuessNumber!))
//  }
  
  var userGuessNumber: Float?
  let game = BullsEyeGame()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTextField()
    game.startNewGame()
    updateView()
  }
  
  
  @IBAction func textFieldDidChageValue(_ sender: UITextField) {
    guard let userInput = userTextField.text,
      userTextField.text!.count <= 3 else {
      userTextField.deleteBackward()
      view.endEditing(true)
      return
    }
    
    guard let number = Int(userInput),
    number <= 100 else {
      userTextField.deleteBackward()
      return
    }
    
    userGuessNumber = Float(number)
  }
  
  
  @IBAction func hitMeButtonDidTap() {
    guard let validatedUserInput = userGuessNumber else {
      alertInvalidData()
      return
    }
    print(validatedUserInput)
    
    playANewRound(with: validatedUserInput)
  }
  
  
  @IBAction func startOverButtonDidTap() {
    game.startNewGame()
    updateView()
  }
  
  
  func playANewRound(with guessNumber: Float) {
    game.calculateRoundResult(for: guessNumber)
    
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
  
  
  func alertInvalidData() {
    let alert = UIAlertController(title: "Error",
                                  message: "Entered data not valid.",
                                  preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default, handler: { action in
      self.updateView()
    })
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  
  func updateView() {
    scoreLabel.text = String(game.gameScore)
    roundLabel.text = String(game.roundNumber)
    slider.value = Float(game.targetValue)
    slider.isEnabled = false
    userTextField.text = nil
    
    print(game.targetValue)
//        addColorTintHint()
  }
  
  
//  func addColorTintHint() {
//    slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDifference)/100.0)
//  }
  
}


extension ViewController: UITextFieldDelegate {
  
  func setupTextField() {
    userTextField.delegate = self
  }
  
  
  /// Dismisses the keyboard when a touch is done outside itself.
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
}
