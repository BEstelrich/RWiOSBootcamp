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
  var compatibilityPersons: [Person] {
    [person1, person2]
  }
  var currentItemIndex = 0
  
  var person1 = Person(id: 1, items: [:])
  var person2 = Person(id: 2, items: [:])
  var currentPerson: Person!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setSilder()
    resetInterface()
  }
  
  
  @IBAction func sliderValueChanged(_ sender: UISlider) {
    print(sender.value.rounded())
    slider.value.round()
  }
  
  
  @IBAction func didPressNextItemButton(_ sender: Any) {
    
    saveScoreForCurrentUser()
    
    if person1.items.count < compatibilityItems.count {
      currentItemIndex += 1
      currentPerson = person1
      questionLabel.text = "User \(currentPerson.id), what do you think about..."
      compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
    } else if person2.items.isEmpty {
      currentItemIndex = 0
      currentPerson = person2
      questionLabel.text = "User \(currentPerson.id), what do you think about..."
      compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
    } else if person2.items.count < compatibilityItems.count {
      currentItemIndex += 1
      currentPerson = person2
      questionLabel.text = "User \(currentPerson.id), what do you think about..."
      compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
    } else {
      let result = calculateCompatibility()
      print(result)
      resetInterface()
      presentScoreAlert()
      
      print("Person \(currentPerson.id) | Items: \(currentPerson.items)")
    }
  }
  
  
  func saveScoreForCurrentUser() {
    let currentItem = compatibilityItems[currentItemIndex]
    currentPerson?.items.updateValue(slider.value.rounded(), forKey: currentItem)
  }
  
  
  func presentScoreAlert() {
    let alert = UIAlertController(title: "Score",
                                  message: "The compatibility between user is \(calculateCompatibility())",
                                  preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default)
    
    alert.addAction(action)
    present(alert, animated: true)
  }
  
  
  func resetInterface() {
    person1.items.removeAll()
    person2.items.removeAll()
    currentPerson = person1
    questionLabel.text = "User \(currentPerson?.id ?? 1), what do you think about..."
    currentItemIndex = 0
    compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
  }
  
  
  func setSilder() {
    slider.isContinuous = false
  }
  
  
  func calculateCompatibility() -> String {
    // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
    print("Calculating!!!!")
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

