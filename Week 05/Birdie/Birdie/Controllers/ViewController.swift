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
  
  var mediaPosts = MediaPostsHandler.shared.mediaPosts
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableView()
  }
  
  
  @IBAction func didPressCreateTextPostButton(_ sender: Any) {
    
  }
  
  
  @IBAction func didPressCreateImagePostButton(_ sender: Any) {
    
  }
  
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func setUpTableView() {
    tableview.delegate = self
    tableview.dataSource = self
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
}
