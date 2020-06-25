// 2020.06.25 | Birdie - TextPostTableViewCell.swift | Copyright © 2020 Jay Strawn. All rights reserved.
import UIKit


@IBDesignable
class TextPostTableViewCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var timeStampLabel: UILabel!
  @IBOutlet weak var textBodyLabel: UILabel!

  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
