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
  var rgb = RGB()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateView()
  }
  
  
  @IBAction func aSliderMoved(sender: UISlider) {
    switch sender {
    case redSlider:
      rgb.r = Int(sender.value)
      redLabel.text = "R: \(rgb.r)"
      
    case greenSlider:
      rgb.g = Int(sender.value)
      greenLabel.text = "G: \(rgb.g)"
      
    case blueSlider:
      rgb.b = Int(sender.value)
      blueLabel.text = "R: \(rgb.b)"
      
    default:
      break
    }
    
    guessLabel.backgroundColor = UIColor(rgbStruct: rgb)
  }
  
  
  @IBAction func showAlert(sender: AnyObject) {
    
  }
  
  
  @IBAction func startOver(sender: AnyObject) {
    game.startNewGame()
    updateView()
    
  }
  
  
  func updateView() {
    targetTextLabel.text = "Match this color"
  }
  
  
}

