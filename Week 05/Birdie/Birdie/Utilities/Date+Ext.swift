// 2020.06.25 | Birdie - Date + Ext.swift | Copyright © 2020 Jay Strawn. All rights reserved.
import UIKit


extension Date {
  
  func toString(withFormat format: String = "d MMM, HH:mm") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    let str = dateFormatter.string(from: self)
    return str
  }
  
}
