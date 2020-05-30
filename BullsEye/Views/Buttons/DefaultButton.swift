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
    self.layer.cornerRadius = 20
    self.layer.masksToBounds = true
  }
  
}
