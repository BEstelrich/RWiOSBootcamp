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
  
  private var sauceAmount = SauceAmount.none
  private var randomImageName: String!
  private var coreDataManager = CoreDataManager()
  
  var delegate: SandwichDataSource?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  
  func setupView() {
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
    guard let sandwichName = nameField.text,
      !sandwichName.isEmpty else {
        let alert = UIAlertController(title: "Missing Name",
                                      message: "You need to enter a sandwich name!",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        return
    }
    
    let newSandwich = SandwichData(name: sandwichName,
                                   sauceAmount: sauceAmount,
                                   imageName: randomImageName)
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
  
}
