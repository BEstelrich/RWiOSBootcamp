//
//  SandwichData.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
import Foundation


enum SauceAmount: Decodable {
  
  case any
  case none
  case tooMuch
  
  var description: String {
    switch self {
    case .any:
      return "Any Amount"
    case .none:
      return "Too Dry"
    case .tooMuch:
      return "Drowning in Sauce"
    }
  }
  
}


struct SandwichData: Decodable {
  
  let name: String
  let sauceAmount: SauceAmount
  let imageName: String
  
}


struct SandwitchSamples {
  
  static let sandwichArray = [SandwichData(name: "Bagel Toast", sauceAmount: .none, imageName: "sandwich1"),
                       SandwichData(name: "Bologna", sauceAmount: .none, imageName: "sandwich2"),
                       SandwichData(name: "Breakfast Roll", sauceAmount: .none, imageName: "sandwich3"),
                       SandwichData(name: "Club", sauceAmount: .none, imageName: "sandwich4"),
                       SandwichData(name: "Sub", sauceAmount: .none, imageName: "sandwich5"),
                       SandwichData(name: "Steak", sauceAmount: .tooMuch, imageName: "sandwich6"),
                       SandwichData(name: "Dunno", sauceAmount: .tooMuch, imageName: "sandwich7"),
                       SandwichData(name: "Torta", sauceAmount: .tooMuch, imageName: "sandwich8"),
                       SandwichData(name: "Ham", sauceAmount: .tooMuch, imageName: "sandwich9"),
                       SandwichData(name: "Lettuce", sauceAmount: .tooMuch, imageName: "sandwich10")]
  
  
  static func randomImageName() -> String {
    let sandwichNum = Int.random(in: 1...15)
    return "sandwich\(sandwichNum)"
  }
  
}


extension SauceAmount: CaseIterable { }


extension SauceAmount: RawRepresentable {
  
  typealias RawValue = String
  
  init?(rawValue: RawValue) {
    switch rawValue {
    case "Either": self = .any
    case "None": self = .none
    case "Too Much": self = .tooMuch
    default: return nil
    }
  }
  
  var rawValue: String {
    switch self {
    case .any: return "Either"
    case .none: return "None"
    case .tooMuch: return "Too Much"
    }
  }
  
}
