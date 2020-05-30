// 2020.05.30 | BullsEye - ViewController.swift | Copyright © 2020 BEstelrich. All rights reserved.
import UIKit


class ColorPickerViewController: UIViewController {
  
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var redValueLabel: UILabel!
  @IBOutlet weak var greenValueLabel: UILabel!
  @IBOutlet weak var blueValueLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  
  @IBAction func setColorButtonDidTap(_ sender: UIButton) {
    print("Set Color button tapped.")
  }
  
  
  @IBAction func resetButtonDidTap(_ sender: UIButton) {
    backgroundView.backgroundColor = UIColor(red: 0,
                                             green: 0,
                                             blue: 0,
                                             alpha: 1)
    redValueLabel.text = String(0)
    greenValueLabel.text = String(0)
    blueValueLabel.text = String(0)
  }
  
  
  @IBAction func infoButtonDidTap(_ sender: UIButton) {
    print("Info button tapped.")
  }
  
}
