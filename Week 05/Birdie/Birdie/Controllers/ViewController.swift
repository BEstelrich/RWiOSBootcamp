//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
import UIKit


class ViewController: UIViewController {
  
  @IBOutlet weak var tableview: UITableView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    fetchForPosts()
  }
  
  
  func fetchForPosts() {
    MediaPostsHandler.shared.getPosts()
  }
  
  
  func createTextPostAlert() {
    let alert = UIAlertController(title: "Create Text Post",
                                  message: "What do you want to post?",
                                  preferredStyle: .alert)
    
    alert.addTextField { (textField) in
      textField.placeholder = "Username"
    }
    
    alert.addTextField { (textField) in
      textField.placeholder = "Post"
    }
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
    
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ (UIAlertAction) in
      let textPost = TextPost(textBody: alert.textFields?[1].text ?? "Anonymous",
                              username: alert.textFields?[0].text ?? "N/A",
                              timeStamp: Date())
      
      MediaPostsHandler.shared.addTextPost(textPost: textPost)
      self.tableview.reloadData()
    }))
    
    present(alert, animated: true)
  }
  
  
  func createImagePostAlert() {
    let alert = UIAlertController(title: "Create Image Post",
                                  message: "What do you want to post?",
                                  preferredStyle: .alert)
    
    alert.addTextField { (textField) in
      textField.placeholder = "Username"
    }
    
    alert.addTextField { (textField) in
      textField.placeholder = "Post"
    }
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
    
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ (UIAlertAction) in
      let imagePost = ImagePost(textBody: alert.textFields?[1].text ?? "Anonymous",
                                username: alert.textFields?[0].text ?? "N/A",
                                timeStamp: Date(),
                                image: UIImage(named: "chop")!)
      
      MediaPostsHandler.shared.addImagePost(imagePost: imagePost)
      self.tableview.reloadData()
    }))
    
    present(alert, animated: true)
  }
  
  
  @IBAction func didPressCreateTextPostButton(_ sender: UIButton) {
    createTextPostAlert()
  }
  
  
  @IBAction func didPressCreateImagePostButton(_ sender: UIButton) {
    createImagePostAlert()
  }
  
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func setupTableView() {
    tableview.delegate = self
    tableview.dataSource = self
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MediaPostsHandler.shared.mediaPosts.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let mediaPost = MediaPostsHandler.shared.mediaPosts[indexPath.row]
    return MediaPostsViewModel.shared.setUpTableViewCell(for: mediaPost, in: tableView)
  }
  
}
