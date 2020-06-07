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
  var guessRGB = RGB()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    game.startNewGame()
    updateView()
  }
  
  
  @IBAction func sliderDidDrag(sender: UISlider) {
    switch sender {
    case redSlider:
      guessRGB.red = Int(sender.value)
      redLabel.text = "R: \(guessRGB.red)"
      
    case greenSlider:
      guessRGB.green = Int(sender.value)
      greenLabel.text = "G: \(guessRGB.green)"
      
    case blueSlider:
      guessRGB.blue = Int(sender.value)
      blueLabel.text = "R: \(guessRGB.blue)"
      
    default:
      break
    }
    
    guessLabel.backgroundColor = UIColor(customRGB: guessRGB)
  }
  
  
  @IBAction func hitMeButtonDidTap(sender: AnyObject) {
    game.calculateRoundResult(for: guessRGB, against: game.targetValue)
    
    targetTextLabel.text = "R: \(game.targetValue.red)   G: \(game.targetValue.green)   B: \(game.targetValue.blue)"
    
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
    guessRGB = RGB()
    
    targetLabel.backgroundColor = UIColor(customRGB: game.targetValue)
    targetTextLabel.text = "Match this color"
    
    guessLabel.backgroundColor = UIColor(customRGB: guessRGB)
    redLabel.text = "R: \(guessRGB.red)"
    greenLabel.text = "G: \(guessRGB.green)"
    blueLabel.text = "B: \(guessRGB.blue)"
    
    redSlider.value = Float(guessRGB.red)
    greenSlider.value = Float(guessRGB.green)
    blueSlider.value = Float(guessRGB.blue)
    
    roundLabel.text = "Round: \(game.roundNumber)"
    scoreLabel.text = "Score: \(game.gameScore)"
  }
  
}

