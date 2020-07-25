// 2020.07.22 | jQuiz - AnswersTableViewCell.swift | Copyright © 2020 Jay Strawn. All rights reserved.
import UIKit


@IBDesignable
class AnswersTableViewCell: UITableViewCell {
  
  static let reuseIdentifier = String(describing: AnswersTableViewCell.self)
  
  @IBOutlet weak var cellBackgroundView: UIView!
  @IBOutlet weak var answerLabel: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    updateAppearance(to: .systemPurple)
  }
  
  
  func populate(with clue: Clue) {
    answerLabel.text = clue.answer?.cleanHTMLAttributes!.capitalized
  }
  
  
  func updateAppearance(to color: UIColor) {
    cellBackgroundView.layer.borderWidth = 0.5
    cellBackgroundView.layer.borderColor = UIColor.black.cgColor
    cellBackgroundView.layer.cornerRadius = 15
    cellBackgroundView.backgroundColor = color.withAlphaComponent(0.8)
  }

}
