// 2020.05.30 | BullsEye - DefaultButton.swift | Copyright © 2020 BEstelrich. All rights reserved.
import UIKit


@IBDesignable class DefaultButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
  
  
  func configure() {
    layer.cornerRadius = 25
    layer.masksToBounds = true
    layer.borderWidth = 2
    layer.borderColor = UIColor.white.cgColor
  }
  
}
