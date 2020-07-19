//
//  AddSandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
import UIKit


class AddSandwichViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var sauceAmountSegmentedControl: UISegmentedControl!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var ratingStepper: UIStepper!
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  

  private var randomImageName: String!
  var delegate: SandwichDataSource?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  
  func setupView() {
    saveButton.isEnabled = false
    randomImageName = "sandwich\(Int.random(in: 1...15))"
    thumbnailImageView.image = UIImage.init(imageLiteralResourceName: randomImageName)
  }

  
  @IBAction func stepperPressed(_ sender: UIStepper) {
    ratingLabel.text = "\(sender.value)"
  }
  
  
  @IBAction func cancelPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func savePressed(_ sender: Any) {
    guard let sandwichName = nameTextField.text else { return }
    
    let newSandwich = SandwichData(name: sandwichName,
                                   sauceAmount: sauceAmountSegmentedControl.selectedSegmentIndex == 0 ? .none : .tooMuch,
                                   imageName: randomImageName,
                                   rating: ratingStepper.value)
    delegate?.saveSandwich(newSandwich)
    dismiss(animated: true, completion: nil)
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
