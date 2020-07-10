// 2020.07.08 | Birdui - Date+Ext.swift | Copyright © 2020 Razeware. All rights reserved.
import Foundation


extension Date {
  
  func toString(format: DateFormatter.Style = .medium) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = format
    dateFormatter.timeStyle = .short
    dateFormatter.timeZone = .current
    return dateFormatter.string(from: self)
  }
  
}

