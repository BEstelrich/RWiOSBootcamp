// 2020.07.17 | SandwichSaturation - SettingsManager.swift | Copyright © 2020 Jeff Rames. All rights reserved.
import UIKit


enum SettingsManager {
  
  static var lastFilterSelectedIndex: Int {
    get { return UserDefaults.standard.object(forKey: "LastFilterSelectedIndex") as? Int ?? 0 }
    set(newValue) { UserDefaults.standard.set(newValue, forKey: "LastFilterSelectedIndex") }
  }
  
  
  static var sortingSelection: SortingSelection {
    get { return SortingSelection(rawValue: UserDefaults.standard.object(forKey: "SortingSelection") as? String ?? "Name") ?? .name }
    set(newValue) { UserDefaults.standard.set(newValue.rawValue, forKey: "SortingSelection") }
  }
  
}


enum SortingSelection: Decodable {
  
  case name
  case sauceAmount
  case rating
  
  var description: String {
    switch self {
    case .name:
      return "Name"
      
    case .sauceAmount:
      return "Sauce amount"
      
    case .rating:
      return "Rating"
    }
  }
  
  
  mutating func toggle() {
    switch self {
    case .name:
      self = .sauceAmount
      
    case .sauceAmount:
      self = .rating
      
    case .rating:
      self = .name
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
      
    case "Rating":
      self = .rating
      
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
      
    case .rating:
      return "Rating"
    }
  }
  
}
