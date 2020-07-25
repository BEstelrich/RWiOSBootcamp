// 2020.07.25 | jQuiz - String+Ext.swift | Copyright © 2020 Jay Strawn. All rights reserved.
import Foundation


extension String {
  
  var cleanHTMLAttributes: String? {
    guard let data = data(using: .utf8) else { return nil }
    do {
      return try NSAttributedString(data: data,
                                    options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                    documentAttributes: nil).string
    } catch let error as NSError {
      print(error.localizedDescription)
      return  nil
    }
  }
  
}
