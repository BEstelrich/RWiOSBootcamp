// 2020.07.17 | SandwichSaturation - SortingBarButtonItem.swift | Copyright © 2020 Jeff Rames. All rights reserved.

import UIKit

class SortingBarButtonItem: UIBarButtonItem {

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  
  func setup() {
    updateSortingImageButton()
  }
  
  
  func updateSortingImageButton() {
    switch UserSettings.sortingSelection {
    case .name:
      self.image = UIImage(systemName: "arrow.up.arrow.down.circle")!
      
    case .sauceAmount:
      self.image = UIImage(systemName: "arrow.up.arrow.down.circle.fill")!
    }
  }
  
}
