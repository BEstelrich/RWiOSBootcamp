// 2020.05.31 | BullsEye - DefaultBackgroundView.swift | Copyright © 2020 BEstelrich. All rights reserved.
import UIKit


@IBDesignable class DefaultBackgroundView: UIView {
  
    override init(frame: CGRect) {
      super.init(frame: frame)
      configure()
    }
    
    
    required init?(coder: NSCoder) {
      super.init(coder: coder)
      configure()
    }
    
    
    func configure() {
      layer.cornerRadius = 20
      layer.masksToBounds = true
    }

}
