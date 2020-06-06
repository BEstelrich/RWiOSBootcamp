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

import Foundation

class BullsEyeGame {
  
  var targetValue = RGB()
  var gameScore = 0
  var roundNumber = 0
  var roundScore = 0
  var roundMessage = "N/A"

  
  func startNewGame() {
    gameScore = 0
    roundScore = 0
    roundNumber = 0
    startNewRound()
  }
  
  
  func startNewRound() {
    roundScore = 0
    roundNumber += 1
    
    targetValue.red = Int.random(in: 0...255)
    targetValue.green = Int.random(in: 0...255)
    targetValue.blue = Int.random(in: 0...255)
  }
  
  
  func calculateRoundResult(for rgbValues: RGB, withTarget target: RGB) {
    let difference = rgbValues.difference(target: target)
    print(difference)
    
    switch difference {
    case 0:
      roundScore += 100
      roundMessage = "Perfect!"
      
    case 1:
      roundScore += 50
      roundMessage = "You almost had it!"
      
    case 2..<5:
      roundMessage = "You almost had it!"
      
    case 5..<10:
      roundMessage = "Pretty good!"
      
    default:
      roundMessage = "Not even close..."
    }

    gameScore += roundScore
  }
  
}
