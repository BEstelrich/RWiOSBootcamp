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
  var selectedImage: UIImage?
  
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
      let textPost = TextPost(username: alert.textFields?[0].text ?? "N/A",
                              timeStamp: Date(),
                              textBody: alert.textFields?[1].text ?? "Anonymous")
      
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
      let imagePost = ImagePost(username: alert.textFields?[0].text ?? "N/A",
                                timeStamp: Date(),
                                textBody: alert.textFields?[1].text ?? "Anonymous",
                                image: self.selectedImage!)
      
      MediaPostsHandler.shared.addImagePost(imagePost: imagePost)
      self.tableview.reloadData()
    }))
    
    present(alert, animated: true)
  }
  
  
  func pickAnImageFromLibrary() {
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    pickerController.allowsEditing = false
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      pickerController.sourceType = .camera
    } else {
      pickerController.sourceType = .photoLibrary
      pickerController.modalPresentationStyle = .fullScreen
    }
    
    present(pickerController, animated: true)
  }
  
  
  @IBAction func didPressCreateTextPostButton(_ sender: UIButton) {
    createTextPostAlert()
  }
  
  
  @IBAction func didPressCreateImagePostButton(_ sender: UIButton) {
    pickAnImageFromLibrary()
  }
  
}


// Implements the protocols required by the TableView.
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func setupTableView() {
    tableview.delegate = self
    tableview.dataSource = self
    tableview.separatorStyle = .none
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MediaPostsHandler.shared.mediaPosts.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let mediaPost = MediaPostsHandler.shared.mediaPosts[indexPath.row]
    return MediaPostsViewModel.shared.setUpTableViewCell(for: mediaPost, in: tableView)
  }
  
}


// Conforms to the ImagePicker required protocols.
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] else { return }
    
    dismiss(animated: true, completion: nil)
    selectedImage = pickedImage as? UIImage
    createImagePostAlert()
  }
  
}
