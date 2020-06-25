//
//  MediaPostViewModel.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
import UIKit


class MediaPostsViewModel {
  
  static let shared = MediaPostsViewModel()
  
  
  func setUpTableViewCell(for post: MediaPost, in tableview: UITableView) -> UITableViewCell {
    if let post = post as? TextPost {
      let cell = tableview.dequeueReusableCell(withIdentifier: TextPostTableViewCell.identifier) as! TextPostTableViewCell
      cell.usernameLabel.text = post.username
      cell.timeStampLabel.text = post.timeStamp.toString()
      cell.textBodyLabel.text = post.textBody
      return cell
    } else if let post = post as? ImagePost {
      let cell = tableview.dequeueReusableCell(withIdentifier: ImagePostTableViewCell.identifier) as! ImagePostTableViewCell
      cell.usernameLabel.text = post.username
      cell.timeStampLabel.text = post.timeStamp.toString()
      cell.textBodyLabel.text = post.textBody
      cell.postImageView.image = post.image
      return cell
    } else {
      let cell = UITableViewCell()
      cell.textLabel?.text = post.textBody
      return cell
    }
  }
  
}
