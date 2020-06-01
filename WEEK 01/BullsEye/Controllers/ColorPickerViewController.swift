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
  @IBOutlet weak var setColorButton: DefaultButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureSlidersForRGB()
  }
  
  
  @IBAction func colorSystemSegmentedControlDidTap(_ sender: UISegmentedControl) {
    sender.selectedSegmentIndex == 0 ? configureSlidersForRGB() : configureSlidersForHSB()
  }
  
  
  @IBAction func firstSliderDidDrag(_ sender: UISlider) {
    firstValueLabel.text = "\(Int(firstSlider.value.rounded()))"
    setColorButton.backgroundColor = updateColorWithCurrentSettings()
  }
  
  
  @IBAction func secondSliderDidDrag(_ sender: UISlider) {
    secondValueLabel.text = "\(Int(secondSlider.value.rounded()))"
    setColorButton.backgroundColor = updateColorWithCurrentSettings()
  }
  
  
  @IBAction func thirdSliderDidDrag(_ sender: UISlider) {
    thirdValueLabel.text = "\(Int(thirdSlider.value.rounded()))"
    setColorButton.backgroundColor = updateColorWithCurrentSettings()
  }
  
  
  @IBAction func setColorButtonDidTap(_ sender: UIButton) {
    let alert = UIAlertController(title: "Color profile",
                                  message: "Define a name for your color profile",
                                  preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save",
                               style: .default) { action in
                                self.updateBackgroundColor()
                                let firstTextField = alert.textFields![0]
                                self.colorNameLabel.text = firstTextField.text != "" ? firstTextField.text : "Color name"
    }
    
    let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .cancel,
                                     handler: nil)
    alert.addTextField { texfield in
      texfield.placeholder = "Write here the profile's name"
    }
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }
  
  
  @IBAction func resetButtonDidTap(_ sender: UIButton) {
    resetSliders()
  }
  
  
  func updateBackgroundColor() {
    if colorSystemSegmentedControl.selectedSegmentIndex == 0 {
      backgroundView.backgroundColor = ColorHelper.createRGB(red: firstSlider.value,
                                                             green: secondSlider.value,
                                                             blue: thirdSlider.value)
    } else if colorSystemSegmentedControl.selectedSegmentIndex == 1 {
      backgroundView.backgroundColor = ColorHelper.createHSB(hue: firstSlider.value,
                                                             saturation: secondSlider.value,
                                                             brightness: thirdSlider.value)
    }
  }
  
  
  func updateColorWithCurrentSettings() -> UIColor {
    if colorSystemSegmentedControl.selectedSegmentIndex == 0 {
      return ColorHelper.createRGB(red: firstSlider.value,
                                   green: secondSlider.value,
                                   blue: thirdSlider.value)
    } else {
      return ColorHelper.createHSB(hue: firstSlider.value,
                                   saturation: secondSlider.value,
                                   brightness: thirdSlider.value)
    }
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
