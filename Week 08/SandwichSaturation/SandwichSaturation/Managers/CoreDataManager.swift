// 2020.07.17 | SandwichSaturation - CoreDataManager.swift | Copyright © 2020 Jeff Rames. All rights reserved.
import UIKit
import CoreData


class CoreDataManager {
  
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  
  
  func saveSandwichesFromJSONToCoreData() -> [Sandwich] {
    guard let sandwichJSONURL = Bundle.main.url(forResource: "Sandwiches", withExtension: "json") else { return [Sandwich]() }
    
    let decoder = JSONDecoder()
    
    do {
      let sandwichData = try Data(contentsOf: sandwichJSONURL)
      let sandwiches = try decoder.decode([SandwichData].self, from: sandwichData)
      sandwiches.forEach { save($0) }
    } catch let error as NSError {
      print("Could not save from JSON: \(error), \(error.userInfo)")
    }
    
    return fetchSandwiches()
  }
  
  
  func fetchSandwiches() -> [Sandwich] {
    var fetchedSandwiches = [Sandwich]()
    do {
      fetchedSandwiches = try appDelegate.persistentContainer.viewContext.fetch(Sandwich.fetchRequest())
      fetchedSandwiches = sorted(fetchedSandwiches, by: SettingsManager.sortingSelection)
    } catch let error as NSError {
      print("Could not fetch: \(error), \(error.userInfo)")
    }
    
    return fetchedSandwiches
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
  
  
  func editRating(for sandwich: Sandwich, with rating: Double) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Sandwich")
    fetchRequest.predicate = NSPredicate(format: "name = %@", sandwich.name)
    
    do {
      let results = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
      
      let result = results[0] as! NSManagedObject
      result.setValue(rating, forKey: "rating")
      appDelegate.saveContext()
    } catch let error as NSError {
      print("Could not edit: \(error), \(error.userInfo)")
    }
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
