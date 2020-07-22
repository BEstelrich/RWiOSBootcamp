// 2020.07.22 | jQuiz - AnswersTableViewCell.swift | Copyright © 2020 Jay Strawn. All rights reserved.
import UIKit


class AnswersTableViewCell: UITableViewCell {
  
  static let reuseIdentifier = String(describing: AnswersTableViewCell.self)
  
  @IBOutlet weak var answerLabel: UILabel!
  
  
  func populate(with clue: Clue) {
    answerLabel.text = clue.answer
  }

}
