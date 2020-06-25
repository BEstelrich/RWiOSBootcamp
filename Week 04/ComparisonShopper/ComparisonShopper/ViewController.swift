//
//  ViewController.swift
//  ComparisonShopper
//
//  Created by Jay Strawn on 6/15/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
import UIKit


class ViewController: UIViewController {
  
  // Left
  @IBOutlet weak var titleLabelLeft: UILabel!
  @IBOutlet weak var imageViewLeft: UIImageView!
  @IBOutlet weak var priceLabelLeft: UILabel!
  @IBOutlet weak var roomLabelLeft: UILabel!
  
  // Right
  @IBOutlet weak var titleLabelRight: UILabel!
  @IBOutlet weak var imageViewRight: UIImageView!
  @IBOutlet weak var priceLabelRight: UILabel!
  @IBOutlet weak var roomLabelRight: UILabel!
  
  var house1: House!
  var house2: House!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpLeftSideUI()
    setUpRightSideUI()
  }
  
  
  func setUpLeftSideUI() {
    house1 = House(address: "1600 Pennsylvania Ave",
                   price: "$1,500,000",
                   bedrooms: "5 bedrooms")
    
    titleLabelLeft.text = house1.address
    priceLabelLeft.text = house1.price
    roomLabelLeft.text = house1.bedrooms
  }
  
  
  func setUpRightSideUI() {
    guard house2 != nil else {
      titleLabelRight.alpha = 0
      imageViewRight.alpha = 0
      priceLabelRight.alpha = 0
      roomLabelRight.alpha = 0
      return
    }
    
    titleLabelRight.alpha = 1
    imageViewRight.alpha = 1
    priceLabelRight.alpha = 1
    roomLabelRight.alpha = 1
    
    titleLabelRight.text = house2.address
    priceLabelRight.text = house2.price
    roomLabelRight.text = house2.bedrooms
  }
  
  
  @IBAction func didPressAddRightHouseButton(_ sender: Any) {
    openAlertView()
  }
  
  
  func openAlertView() {
    let alert = UIAlertController(title: "Alert Title", message: "Alert Message", preferredStyle: UIAlertController.Style.alert)
    
    alert.addTextField { (textField) in
       textField.placeholder = "address"
     }
     
     alert.addTextField { (textField) in
       textField.placeholder = "price"
     }
    
    alert.addTextField { (textField) in
      textField.placeholder = "bedrooms"
    }
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
    
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction) in
      self.house2 = House(address: alert.textFields?[0].text,
                          price: alert.textFields?[1].text,
                          bedrooms: alert.textFields?[2].text)
      
      self.setUpRightSideUI()
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
}
