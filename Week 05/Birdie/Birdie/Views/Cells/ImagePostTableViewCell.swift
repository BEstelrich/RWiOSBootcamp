// 2020.06.25 | Birdie - ImagePostTableViewCell.swift | Copyright © 2020 Jay Strawn. All rights reserved.
import UIKit


class ImagePostTableViewCell: UITableViewCell {
  
  static let identifier = "imageCell"
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var timeStampLabel: UILabel!
  @IBOutlet weak var textBodyLabel: UILabel!
  @IBOutlet weak var postImageView: UIImageView!
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
