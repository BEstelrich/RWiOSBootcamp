// 2020.06.25 | Birdie - TextPostTableViewCell.swift | Copyright © 2020 Jay Strawn. All rights reserved.
import UIKit


class TextPostTableViewCell: UITableViewCell {
  
  static let identifier = "textCell"
  
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var timeStampLabel: UILabel!
  @IBOutlet weak var textBodyLabel: UILabel!
  @IBOutlet weak var shapeView: UIView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupCell()
  }

  
  func setupCell() {
    shapeView.layer.cornerRadius = 15
    shapeView.layer.masksToBounds = true
  }
  
  
}
