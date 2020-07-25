// 2020.07.25 | jQuiz - JQuizGame.swift | Copyright © 2020 Jay Strawn. All rights reserved.
import Foundation


class JQuizGame {
  
  var clues: [Clue] = []
  var currentClue: Clue?
  var points: Int = 0

  
  func resetGame() {
    clues = []
    currentClue = nil
    points = 0
  }

  
  func checkIfCorrect(_ answer: String) -> Bool {
    if currentClue?.answer?.cleanHTMLAttributes!.capitalized == answer {
      points += currentClue?.value ?? 100
      return true
    } else {
      return false
    }
  }
  
  
  func setupGame(completion: @escaping () -> Void) {
    NetworkService.shared.getRandomCategory(completion: { (clues, error) in
      guard let category = clues?.first?.category,
        error == nil else { return }
      
      NetworkService.shared.getAllCluesInCategory(category) { (clues, error) in
        guard let clues = clues,
          error == nil else { return }
        
        self.clues.removeAll()
       
        let uniqueClues = Array(Set(clues)).shuffled()

        for clue in uniqueClues where self.clues.count < 4 {
          self.clues.append(clue)
        }
        
        self.currentClue = self.clues.first
        self.clues.shuffle()
        completion()
      }
    })
  }

}
