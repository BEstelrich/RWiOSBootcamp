//
//  MediaPostProtocol.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
import Foundation


// We use this protocol so both text posts and image posts
// can be in the MediaPostsHandler.shared.mediaPosts array
protocol MediaPost {
  
  var username: String { get set }
  var textBody: String? { get set }
  var timeStamp: Date { get set }
  
}
