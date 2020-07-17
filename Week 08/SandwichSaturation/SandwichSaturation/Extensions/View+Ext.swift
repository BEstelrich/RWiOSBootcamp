// 2020.07.17 | SandwichSaturation - View+Ext.swift | Copyright © 2020 Jeff Rames. All rights reserved.
import UIKit


extension UIView {
  
  func roundCorners(by radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.layer.masksToBounds = true
  }
  
}
