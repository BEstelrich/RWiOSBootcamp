//
//  MediaPosts.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
import UIKit


class MediaPostsHandler: NSObject {
  
  static let shared = MediaPostsHandler()
  var mediaPosts: [MediaPost] = []
  
  
  private override init() {}
  
  
  func getPosts() {
    let imagePost1 = ImagePost(username: "Jay",
                               timeStamp: Date(timeIntervalSince1970: 10000),
                               textBody: "I love debugging software!",
                               image: UIImage(named: "chop")!)
    
    let imagePost2 = ImagePost(username: "Audrey",
                               timeStamp: Date(timeIntervalSince1970: 30000),
                               textBody: "Went to the Aquarium today :]",
                               image: UIImage(named: "octopus")!)
    
    let textPost1 = TextPost(username: "Bhagat",
                             timeStamp: Date(timeIntervalSince1970: 20000),
                             textBody: "Hello World!")
    
    let textPost2 = TextPost(username: "Jeff",
                             timeStamp: Date(timeIntervalSince1970: 40000),
                             textBody: "This is my favorite social media app!")
    
    mediaPosts = [imagePost1, imagePost2, textPost1, textPost2]
    mediaPosts = mediaPosts.sorted(by: { $0.timeStamp > $1.timeStamp })
  }
  
  
  func addTextPost(textPost: TextPost) {
    mediaPosts.append(textPost)
    mediaPosts = mediaPosts.sorted(by: { $0.timeStamp > $1.timeStamp })
  }
  
  
  func addImagePost(imagePost: ImagePost) {
    mediaPosts.append(imagePost)
    mediaPosts = mediaPosts.sorted(by: { $0.timeStamp > $1.timeStamp })
  }
  
}
