//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
import UIKit


class ViewController: UIViewController {
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var compatibilityItemLabel: UILabel!
  @IBOutlet weak var slider: UISlider!
  
  var compatibilityItems = ["Cats", "Dogs"] // Add more!
  var currentItemIndex = 0
  
  var person1 = Person(id: 1, items: [:])
  var person2 = Person(id: 2, items: [:])
  var currentPerson: Person?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resetInterface()
  }
  
  
  @IBAction func sliderValueChanged(_ sender: UISlider) {
    print(sender.value)
    let currentItem = compatibilityItems[currentItemIndex]
    currentPerson?.items.updateValue(slider.value, forKey: currentItem)
    print(currentPerson)
  }
  
  
  @IBAction func didPressNextItemButton(_ sender: Any) {
//    if currentItemIndex < compatibilityItems.count - 1 {
//      currentItemIndex += 1
//      compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
//      questionLabel.text = "User 1, what do you think about..."
//    } else {
//      currentItemIndex = 0
//      compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
//      questionLabel.text = "User 2, what do you think about..."
//    }
    
//    if person1.items.isEmpty,
//      currentItemIndex < compatibilityItems.count - 1 {
//      currentItemIndex += 1
//      compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
//      questionLabel.text = "User 1, what do you think about..."
//      print(currentPerson?.items)
//    } else if !person1.items.isEmpty,
//      currentItemIndex < compatibilityItems.count - 1 {
//      currentItemIndex += 1
//      compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
//      questionLabel.text = "User 2, what do you think about..."
//      print(currentPerson?.items)
//    } else {
//      currentItemIndex = 0
//    }
    
    if currentItemIndex < compatibilityItems.count - 1 {
      currentItemIndex += 1
      compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
      updatePerson()
      questionLabel.text = "User \(currentPerson?.id), what do you think about..."
      print(currentPerson)
    } else {
      currentItemIndex = 0
    }
    
    print(currentItemIndex)
  }
  
  
  func resetInterface() {
    questionLabel.text = "User 1, what do you think about..."
    currentItemIndex = 0
    compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
  }
  
  
  func updatePerson() {
    if person1.items.isEmpty,
      currentItemIndex < compatibilityItems.count - 1 {
      currentPerson = person1
    } else if !person1.items.isEmpty,
      currentItemIndex < compatibilityItems.count - 1 {
      currentPerson = person2
    } else if !person1.items.isEmpty,
      !person2.items.isEmpty {
      let result = calculateCompatibility()
      print(result)
    }
  }
  
  
  func calculateCompatibility() -> String {
    // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
    var percentagesForAllItems: [Double] = []
    
    for (key, person1Rating) in person1.items {
      let person2Rating = person2.items[key] ?? 0
      let difference = abs(person1Rating - person2Rating)/5.0
      percentagesForAllItems.append(Double(difference))
    }
    
    let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
    let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
    print(matchPercentage, "%")
    let matchString = 100 - (matchPercentage * 100).rounded()
    return "\(matchString)%"
  }
  
}

