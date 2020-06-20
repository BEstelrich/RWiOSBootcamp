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
  
  var compatibilityItems = ["Cats", "Dogs", "Snakes"] // Add more!
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
    slider.value.round()
  }
  
  
  @IBAction func didPressNextItemButton(_ sender: Any) {
    print("User: \(currentPerson.id), round: \(currentItemIndex + 1)")
    
    if person1.items.count < compatibilityItems.count {
      saveScoreForCurrentUser()
      person1 = Person(id: currentPerson.id, items: currentPerson.items)
      updateCurrentIndex()
      
      if person1.items.count == compatibilityItems.count {
        currentPerson = person2
      }
      
      compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
      questionLabel.text = "User \(currentPerson.id), what do you think about..."
      
      print("👍1")
      print("Person \(person1.id) | Items: \(person1.items)")
      print("Person \(person2.id) | Items: \(person2.items)")
    } else if person2.items.count < compatibilityItems.count {
      saveScoreForCurrentUser()
      person2 = Person(id: currentPerson.id, items: currentPerson.items)
      updateCurrentIndex()
      compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
      questionLabel.text = "User \(currentPerson.id), what do you think about..."
      
      print("👍2")
      print("Person \(person1.id) | Items: \(person1.items)")
      print("Person \(person2.id) | Items: \(person2.items)")
      
      if person2.items.count == compatibilityItems.count {
        presentScoreAlert()
        resetInterface()
      }
      
    }

    slider.value = 3.0
  }
  
  
  func updateCurrentIndex() {
    if currentItemIndex < compatibilityItems.count - 1 {
      currentItemIndex += 1
    } else {
      currentItemIndex = 0
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
    currentItemIndex = 0
    compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
    questionLabel.text = "User \(currentPerson?.id ?? 1), what do you think about..."
  }
  
  
  func setSilder() {
    slider.isContinuous = false
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

