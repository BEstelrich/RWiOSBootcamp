// 2020.07.17 | SandwichSaturation - CellBackgroundView.swift | Copyright © 2020 Jeff Rames. All rights reserved.
import UIKit


@IBDesignable
class CellBackgroundView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }


  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }


  func setup() {
    self.roundCorners(by: 10)
  }

}
