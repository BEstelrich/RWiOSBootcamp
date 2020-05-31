// 2020.05.30 | BullsEye - ViewController.swift | Copyright © 2020 BEstelrich. All rights reserved.
import UIKit

class ColorPickerViewController: UIViewController {
  
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var colorNameLabel: UILabel!
  
  @IBOutlet weak var firstColorLabel: UILabel!
  @IBOutlet weak var secondColorLabel: UILabel!
  @IBOutlet weak var thirdColorLabel: UILabel!
  
  @IBOutlet weak var firstValueLabel: UILabel!
  @IBOutlet weak var secondValueLabel: UILabel!
  @IBOutlet weak var thirdValueLabel: UILabel!
  
  @IBOutlet weak var firstSlider: UISlider!
  @IBOutlet weak var secondSlider: UISlider!
  @IBOutlet weak var thirdSlider: UISlider!
  
  @IBOutlet weak var colorSystemSegmentedControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureSlidersForRGB()
  }
  
  @IBAction func colorSystemSegmentedControlDidTap(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      configureSlidersForRGB()
    } else {
      configureSlidersForHSB()
    }
  }
  
  @IBAction func redSliderDidDrag(_ sender: UISlider) {
    firstValueLabel.text = "\(Int(firstSlider.value.rounded()))"
  }
  
  
  @IBAction func greenSliderDidDrag(_ sender: UISlider) {
    secondValueLabel.text = "\(Int(secondSlider.value.rounded()))"
  }
  
  
  @IBAction func blueSliderDidDrag(_ sender: UISlider) {
    thirdValueLabel.text = "\(Int(thirdSlider.value.rounded()))"
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
    resetSliders()
  }
  
  
  func createRGBColor() -> UIColor {
    let userSelectedColor = UIColor(red: convertToRGB(firstSlider.value),
                                    green: convertToRGB(thirdSlider.value),
                                    blue: convertToRGB(secondSlider.value),
                                    alpha: 1.0)
    return userSelectedColor
  }
  
  
  func createHSBColor() -> UIColor {
    let userSelectedColor = UIColor(hue: convertToHue(firstSlider.value),
                                    saturation: convertToSaturation(secondSlider.value),
                                    brightness: convertToBrightness(thirdSlider.value),
                                    alpha: 1.0)
    return userSelectedColor
  }
  
  
  func updateBackgroundColor() {
    if colorSystemSegmentedControl.selectedSegmentIndex == 0 {
      backgroundView.backgroundColor = createRGBColor()
    } else if colorSystemSegmentedControl.selectedSegmentIndex == 1 {
      backgroundView.backgroundColor = createHSBColor()
    }
  }
  
  
  func convertToRGB(_ value: Float) -> CGFloat {
    let roundedValue = CGFloat(value.rounded())
    let convertedValue = roundedValue / 255
    return convertedValue
  }
  
  
  func convertToHue(_ value: Float) -> CGFloat {
    let roundedValue = CGFloat(value.rounded())
    let convertedValue = roundedValue / 360
    return convertedValue
  }
  
  
  func convertToSaturation(_ value: Float) -> CGFloat {
    let roundedValue = CGFloat(value.rounded())
    let convertedValue = roundedValue / 100
    return convertedValue
  }
  
  
  func convertToBrightness(_ value: Float) -> CGFloat {
    let roundedValue = CGFloat(value.rounded())
    let convertedValue = roundedValue / 100
    return convertedValue
  }
  
  
  func configureSlidersForRGB() {
    firstColorLabel.text = "Red"
    firstSlider.minimumValue = 0
    firstSlider.maximumValue = 255
    
    secondColorLabel.text = "Green"
    secondSlider.minimumValue = 0
    secondSlider.maximumValue = 255
    
    thirdColorLabel.text = "Blue"
    thirdSlider.minimumValue = 0
    thirdSlider.maximumValue = 255
    
    resetSliders()
  }
  
  
  func configureSlidersForHSB() {
    firstColorLabel.text = "Hue"
    firstSlider.minimumValue = 0
    firstSlider.maximumValue = 360
    
    secondColorLabel.text = "Saturation"
    secondSlider.minimumValue = 0
    secondSlider.maximumValue = 100
    
    thirdColorLabel.text = "Brightness"
    thirdSlider.minimumValue = 0
    thirdSlider.maximumValue = 100
    
    resetSliders()
  }
  
  
  func resetSliders() {
    backgroundView.backgroundColor = UIColor(red: 0,
                                             green: 0,
                                             blue: 0,
                                             alpha: 1)
    firstValueLabel.text = String(0)
    secondValueLabel.text = String(0)
    thirdValueLabel.text = String(0)
    
    firstSlider.value = 0
    thirdSlider.value = 0
    secondSlider.value = 0
  }
}
