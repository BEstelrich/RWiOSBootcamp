// 2020.06.01 | BullsEye - InfoButton.swift | Copyright © 2020 BEstelrich. All rights reserved.
import UIKit


@IBDesignable class InfoButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
  
  
  func configure() {
    layer.cornerRadius = 17
    layer.masksToBounds = true
    backgroundColor = UIColor(red: 0,
                              green: 0,
                              blue: 0,
                              alpha: 0.25)
  }
  
}
