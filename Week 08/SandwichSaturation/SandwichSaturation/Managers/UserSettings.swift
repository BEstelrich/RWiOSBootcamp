// 2020.07.17 | SandwichSaturation - UserSettings.swift | Copyright © 2020 Jeff Rames. All rights reserved.
import UIKit


enum UserSettings {
  
  static var lastFilterSelectedIndex: Int {
    get { return UserDefaults.standard.object(forKey: "LastFilterSelectedIndex") as? Int ?? 0 }
    set(newValue) { UserDefaults.standard.set(newValue, forKey: "LastFilterSelectedIndex") }
  }
  
  
  static var sortingSelection: String {
    get { return UserDefaults.standard.object(forKey: "SortingSelection") as? String ?? "Name" }
    set(newValue) { UserDefaults.standard.set(newValue, forKey: "SortingSelection") }
  }
  
}


enum SortingSelection: Decodable {
  
  case name
  case sauceAmount
  
  var description: String {
    switch self {
    case .name:
      return "Name"
    case .sauceAmount:
      return "Sauce amount"
    }
  }
  
}


extension SortingSelection: CaseIterable, RawRepresentable {
  
  init?(rawValue: String) {
    switch rawValue {
    case "Name":
      self = .name
      
    case "Sauce amount":
      self = .sauceAmount
      
    default:
      return nil
    }
  }
  
  var rawValue: String {
    switch self {
    case .name:
      return "Name"
      
    case .sauceAmount:
      return "Sauce amount"
    }
  }
  
}


extension String {
  
  func convertToSortingSelection() -> SortingSelection {
    switch self {
    case "Name":
      return .name
      
    case "Sauce amount":
      return .sauceAmount
      
    default:
      return .name
    }
  }
  
}
