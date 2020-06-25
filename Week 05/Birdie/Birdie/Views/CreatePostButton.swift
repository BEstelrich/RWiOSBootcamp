// 2020.06.25 | Birdie - CreatePostButton.swift | Copyright © 2020 Jay Strawn. All rights reserved.
import UIKit


@IBDesignable
class CreatePostButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButton()
  }
  
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupButton()
  }
  

  func setupButton() {
    layer.cornerRadius = 10
    layer.masksToBounds = true
    layer.borderWidth = 2
    layer.borderColor = UIColor.secondaryLabel.cgColor
  }

}
