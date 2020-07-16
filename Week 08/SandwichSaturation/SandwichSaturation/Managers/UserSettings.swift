// 2020.07.17 | SandwichSaturation - UserSettings.swift | Copyright © 2020 Jeff Rames. All rights reserved.
import UIKit


enum UserSettings {
  
  static var lastFilterSelectedIndex: Int {
    get { return UserDefaults.standard.object(forKey: "LastFilterSelectedIndex") as? Int ?? 0 }
    set(newValue) { UserDefaults.standard.set(newValue, forKey: "LastFilterSelectedIndex") }
  }
  
  
  static var sortingMethod: SortingSelection {
    get { return UserDefaults.standard.object(forKey: "SortingSelection") as? SortingSelection ?? .name }
    set(newValue) { UserDefaults.standard.set(newValue, forKey: "SortingSelection") }
  }
  
}



enum SortingSelection {
  
  case name
  case sauceAmount
  
}
