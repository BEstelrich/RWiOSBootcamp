//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
import UIKit


class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    fetchForPosts()
  }
  
  
  func fetchForPosts() {
    MediaPostsHandler.shared.getPosts()
  }
  
  
  @IBAction func didPressCreateTextPostButton(_ sender: UIButton) {
    MediaPostsViewModel.shared.createTextPost(for: tableView, in: self)
  }
  
  
  @IBAction func didPressCreateImagePostButton(_ sender: UIButton) {
    MediaPostsViewModel.shared.presentImagePicker(in: self)
  }
  
}


// Implements the protocols required by the TableView.
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MediaPostsHandler.shared.mediaPosts.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let mediaPost = MediaPostsHandler.shared.mediaPosts[indexPath.row]
    return MediaPostsViewModel.shared.setUpTableViewCell(for: mediaPost, in: tableView)
  }
  
  
  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      MediaPostsHandler.shared.removePost(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}


// Conforms to the ImagePicker required protocols.
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let pickedImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
    
    dismiss(animated: true, completion: {
      MediaPostsViewModel.shared.createImagePost(for: self.tableView,
                                                 with: pickedImage,
                                                 in: self)
    })
  }
  
}
