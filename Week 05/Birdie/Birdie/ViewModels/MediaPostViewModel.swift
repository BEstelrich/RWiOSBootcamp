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
  
  
  func setUpTableViewCell(for post: MediaPost, in tableView: UITableView) -> UITableViewCell {
    if let post = post as? TextPost {
      let cell = tableView.dequeueReusableCell(withIdentifier: TextPostTableViewCell.identifier) as! TextPostTableViewCell
      cell.usernameLabel.text = post.username
      cell.timeStampLabel.text = post.timeStamp.toString()
      cell.textBodyLabel.text = post.textBody
      return cell
    } else if let post = post as? ImagePost {
      let cell = tableView.dequeueReusableCell(withIdentifier: ImagePostTableViewCell.identifier) as! ImagePostTableViewCell
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
  
  
  func presentImagePicker(in viewController: UIViewController) {
    DispatchQueue.main.async {
      let pickerController = UIImagePickerController()
      pickerController.delegate = viewController as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
      pickerController.allowsEditing = false
      
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
        pickerController.sourceType = .camera
      } else {
        pickerController.sourceType = .photoLibrary
        pickerController.modalPresentationStyle = .fullScreen
      }
      
      viewController.present(pickerController, animated: true)
    }
  }
  
  
  func createTextPost(for tableView: UITableView, in viewController: UIViewController) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: "Create Text Post",
                                    message: "What do you want to post?",
                                    preferredStyle: .alert)
      
      alert.addTextField { (textField) in
        textField.placeholder = "Username"
      }
      
      alert.addTextField { (textField) in
        textField.placeholder = "Post"
      }
      
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
      
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ (UIAlertAction) in
        let textPost = TextPost(username: alert.textFields?[1].text ?? "Anonymous",
                                timeStamp: Date(),
                                textBody: alert.textFields?[1].text)
        
        MediaPostsHandler.shared.addTextPost(textPost: textPost)
        tableView.reloadData()
      }))
      
      viewController.present(alert, animated: true)
    }
  }
  
  
  func createImagePost(for tableView: UITableView,
                            with image: UIImage,
                            in viewController: UIViewController) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: "Create Image Post",
                                    message: "What do you want to post?",
                                    preferredStyle: .alert)
      
      alert.addTextField { (textField) in
        textField.placeholder = "Username"
      }
      
      alert.addTextField { (textField) in
        textField.placeholder = "Post"
      }
      
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
      
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ (UIAlertAction) in
        let imagePost = ImagePost(username: alert.textFields?[1].text ?? "Anonymous",
                                  timeStamp: Date(),
                                  textBody: alert.textFields?[1].text,
                                  image: image)
        
        MediaPostsHandler.shared.addImagePost(imagePost: imagePost)
        tableView.reloadData()
      }))
      
      viewController.present(alert, animated: true)
    }
  }
  
}
