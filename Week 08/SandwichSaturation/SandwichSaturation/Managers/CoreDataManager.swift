// 2020.07.17 | SandwichSaturation - CoreDataManager.swift | Copyright © 2020 Jeff Rames. All rights reserved.
import UIKit


class CoreDataManager {
  
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  
  
  func saveSandwichesFromJSONToCoreData() -> [Sandwich] {
    guard let sandwichJSONURL = Bundle.main.url(forResource: "Sandwiches", withExtension: "json") else { return [Sandwich]() }
    
    let decoder = JSONDecoder()
    
    do {
      let sandwichData = try Data(contentsOf: sandwichJSONURL)
      let sandwiches = try decoder.decode([SandwichData].self, from: sandwichData)
      sandwiches.forEach { save($0) }
    } catch let error {
      print(error.localizedDescription)
    }
    
    return fetchSandwiches()
  }
  
  
  func fetchSandwiches() -> [Sandwich] {
    var savedSandwiches = [Sandwich]()
    do {
      savedSandwiches = try appDelegate.persistentContainer.viewContext.fetch(Sandwich.fetchRequest())
      savedSandwiches = sorted(savedSandwiches, by: UserSettings.sortingSelection)
    } catch let error {
      print(error.localizedDescription)
    }
    
    return savedSandwiches
  }
  
  
  func save(_ sandwich: SandwichData) {
    let newSandwich = Sandwich(context: self.appDelegate.persistentContainer.viewContext)
    newSandwich.name = sandwich.name
    newSandwich.sauceAmount = sandwich.sauceAmount.rawValue
    newSandwich.imageName = sandwich.imageName
    newSandwich.rating = sandwich.rating
    appDelegate.saveContext()
  }
  
  
  func delete(_ sandwich: Sandwich) {
    appDelegate.persistentContainer.viewContext.delete(sandwich)
    appDelegate.saveContext()
  }
  
  
  func sorted(_ sandwiches: [Sandwich], by sortingSelection: SortingSelection) -> [Sandwich] {
    switch sortingSelection {
    case .name:
      return sandwiches.sorted { $0.name.lowercased() < $1.name.lowercased() }

    case .sauceAmount:
      return sandwiches.sorted { $0.name.lowercased() < $1.name.lowercased() }.sorted { $0.sauceAmount.lowercased() < $1.sauceAmount.lowercased() }
      
    case .rating:
      return sandwiches.sorted { $0.name.lowercased() < $1.name.lowercased() }.sorted { $0.rating > $1.rating }
    }
  }

  
}
