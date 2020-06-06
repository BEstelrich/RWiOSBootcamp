/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var targetTextLabel: UILabel!
  @IBOutlet weak var guessLabel: UILabel!
  
  @IBOutlet weak var redLabel: UILabel!
  @IBOutlet weak var greenLabel: UILabel!
  @IBOutlet weak var blueLabel: UILabel!
  
  @IBOutlet weak var redSlider: UISlider!
  @IBOutlet weak var greenSlider: UISlider!
  @IBOutlet weak var blueSlider: UISlider!
  
  @IBOutlet weak var roundLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  
  let game = BullsEyeGame()
  var userRGB = RGB()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateView()
  }
  
  
  @IBAction func sliderDidDrag(sender: UISlider) {
    switch sender {
    case redSlider:
      userRGB.red = Int(sender.value)
      redLabel.text = "R: \(userRGB.red)"
      
    case greenSlider:
      userRGB.green = Int(sender.value)
      greenLabel.text = "G: \(userRGB.green)"
      
    case blueSlider:
      userRGB.blue = Int(sender.value)
      blueLabel.text = "R: \(userRGB.blue)"
      
    default:
      break
    }
    
    guessLabel.backgroundColor = UIColor(rgb: userRGB)
  }
  
  
  @IBAction func hitMeButtonDidTap(sender: AnyObject) {
    targetTextLabel.text = ""
    
    game.calculateRoundResult(for: userRGB, withTarget: game.targetValue)
    
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
  
  
  @IBAction func startOverButtonDidTap(sender: AnyObject) {
    game.startNewGame()
    updateView()
  }
  
  
  func updateView() {
    targetTextLabel.text = "Match this color"
    targetLabel.backgroundColor = UIColor(rgb: game.targetValue)
    
    userRGB = RGB()
    guessLabel.backgroundColor = UIColor(rgb: userRGB)
    redLabel.text = "R: \(userRGB.red)"
    greenLabel.text = "G: \(userRGB.green)"
    blueLabel.text = "B: \(userRGB.blue)"
    
    redSlider.value = Float(userRGB.red)
    greenSlider.value = Float(userRGB.green)
    blueSlider.value = Float(userRGB.blue)
    
    roundLabel.text = "Round: \(game.roundNumber)"
    scoreLabel.text = "Score: \(game.gameScore)"
  }
  
  
}

