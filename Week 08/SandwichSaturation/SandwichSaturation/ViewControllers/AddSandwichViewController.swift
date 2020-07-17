//
//  AddSandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
import UIKit


class AddSandwichViewController: UIViewController {
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var sauceAmountSegmentedControl: UISegmentedControl!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBOutlet weak var ratingLabel: UILabel!
  
  private var sauceAmount = SauceAmount.none
  private var randomImageName: String!
  private var rating = 0.0
  private var coreDataManager = CoreDataManager()
  
  var delegate: SandwichDataSource?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  
  func setupView() {
    saveButton.isEnabled = false
    randomImageName = "sandwich\(Int.random(in: 1...15))"
    imageView.image = UIImage.init(imageLiteralResourceName: randomImageName)
  }

  
  @IBAction func sauceAmountChanged(_ sender: UISegmentedControl) {
    sauceAmount = sauceAmountSegmentedControl.selectedSegmentIndex == 0 ? .none : .tooMuch
  }
  
  
  @IBAction func cancelPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func savePressed(_ sender: Any) {
    guard let sandwichName = nameField.text else { return }
    
    let newSandwich = SandwichData(name: sandwichName,
                                   sauceAmount: sauceAmount,
                                   imageName: randomImageName,
                                   rating: rating)
    delegate?.saveSandwich(newSandwich)
    dismiss(animated: true, completion: nil)
  }

  
  @IBAction func stepperPressed(_ sender: UIStepper) {
    rating = sender.value
    ratingLabel.text = "\(rating)"
  }
  
}


// MARK: - UITextFieldDelegate
extension AddSandwichViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
  

  func textFieldDidChangeSelection(_ textField: UITextField) {
    saveButton.isEnabled = textField.text!.isEmpty ? false : true
  }
  
}
