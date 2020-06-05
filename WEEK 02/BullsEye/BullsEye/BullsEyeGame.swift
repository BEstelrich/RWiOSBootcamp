// 2020.06.05 | BullsEye - BullsEyeGame.swift | Copyright © 2020 Ray Wenderlich. All rights reserved.
import Foundation


class BullsEyeGame {
  
  var targetValue = 0
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
    roundNumber += 1
    targetValue = Int.random(in: 1...100)
  }
  
  
  func calculateRoundResult(for sliderValue: Float) {
    let difference = abs(targetValue - Int(sliderValue))
    roundScore = 100 - difference
    
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
