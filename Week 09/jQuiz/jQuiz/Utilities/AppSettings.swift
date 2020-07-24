// 2020.07.24 | jQuiz - AppSettings.swift | Copyright © 2020 Jay Strawn. All rights reserved.
import Foundation


class AppSettings {
  
  private static let userDefaults = UserDefaults.standard

  static var isSoundEnabled: Bool {
    get {
      return userDefaults.bool(forKey: Constants.Key.isSoundEnabled)
    } set {
      userDefaults.set(newValue, forKey: Constants.Key.isSoundEnabled)
    }
  }
  
  static func isSoundEnabledToggle() {
    isSoundEnabled = isSoundEnabled ? false : true
  }

}
