// 2020.05.30 | BullsEye - ViewController.swift | Copyright © 2020 BEstelrich. All rights reserved.
import UIKit

class ColorPickerViewController: UIViewController {
  
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var colorNameLabel: UILabel!
  
  @IBOutlet weak var redValueLabel: UILabel!
  @IBOutlet weak var greenValueLabel: UILabel!
  @IBOutlet weak var blueValueLabel: UILabel!
  
  @IBOutlet weak var redSlider: UISlider!
  @IBOutlet weak var greenSlider: UISlider!
  @IBOutlet weak var blueSlider: UISlider!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureSlidersForRGB()
  }
  
  
  @IBAction func redSliderDidDrag(_ sender: UISlider) {
    redValueLabel.text = "\(Int(redSlider.value.rounded()))"
  }
  
  
  @IBAction func greenSliderDidDrag(_ sender: UISlider) {
    greenValueLabel.text = "\(Int(greenSlider.value.rounded()))"
  }
  
  
  @IBAction func blueSliderDidDrag(_ sender: UISlider) {
    blueValueLabel.text = "\(Int(blueSlider.value.rounded()))"
  }
  
  
  @IBAction func setColorButtonDidTap(_ sender: UIButton) {
    let alert = UIAlertController(title: "Save the RGB",
                                  message: "Save color name",
                                  preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save",
                               style: .default) { action in
                                self.updateBackgroundColor()
                                let firstTextField = alert.textFields![0]
                                self.colorNameLabel.text = firstTextField.text
    }
    
    let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .cancel,
                                     handler: nil)
    alert.addTextField { texfield in
      texfield.placeholder = "Write your color's name"
    }
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }
  
  
  @IBAction func resetButtonDidTap(_ sender: UIButton) {
    backgroundView.backgroundColor = UIColor(red: 0,
                                             green: 0,
                                             blue: 0,
                                             alpha: 1)
    redValueLabel.text = String(0)
    greenValueLabel.text = String(0)
    blueValueLabel.text = String(0)
    
    redSlider.value = 0
    blueSlider.value = 0
    greenSlider.value = 0
  }
  
  
  @IBAction func infoButtonDidTap(_ sender: UIButton) {
    print("Info button tapped.")
  }
  
  
  func createRGBColor() -> UIColor {
    let userSelectedColor = UIColor(red: convertToRGBFromSlider(value: redSlider.value),
                                    green: convertToRGBFromSlider(value: blueSlider.value),
                                    blue: convertToRGBFromSlider(value: greenSlider.value),
                                    alpha: 1.0)
    return userSelectedColor
  }
  
  
  func updateBackgroundColor() {
    backgroundView.backgroundColor = createRGBColor()
  }
  
  
  func convertToRGBFromSlider(value: Float) -> CGFloat {
    let roundedValue = CGFloat(value.rounded())
    let convertedValue = roundedValue / 255
    return convertedValue
  }
  
  
  func configureSlidersForRGB() {
    redSlider.minimumValue = 0
    redSlider.maximumValue = 255
    
    greenSlider.minimumValue = 0
    greenSlider.maximumValue = 255
    
    blueSlider.minimumValue = 0
    blueSlider.maximumValue = 255
  }
  
}
