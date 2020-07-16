//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
import UIKit
import CoreData

protocol SandwichDataSource {
  func saveSandwich(_: SandwichData)
}


class SandwichViewController: UITableViewController, SandwichDataSource {
  
  let searchController = UISearchController(searchResultsController: nil)
  var sandwiches = [SandwichData]()
  var filteredSandwiches = [SandwichData]()
  
  private var lastFilterSelectedIndex: Int {
    get { return UserDefaults.standard.object(forKey: "LastFilterSelectedIndex") as? Int ?? 0 }
    set(newValue) { UserDefaults.standard.set(newValue, forKey: "LastFilterSelectedIndex") }
  }

  
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadSandwiches()
    setupSearchController()
  }

  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  
  func loadSandwiches() {
    guard let sandwichJSONURL = Bundle.main.url(forResource: "Sandwiches", withExtension: "json") else { return }
    
    let decoder = JSONDecoder()
    
    do {
      let sandwichData = try Data(contentsOf: sandwichJSONURL)
      let sandwiches = try decoder.decode([SandwichData].self, from: sandwichData)
      self.sandwiches = sandwiches
      print(sandwiches)
    } catch let error {
      print(error)
    }
  }
  
  
  func saveSandwich(_ sandwich: SandwichData) {
    let newSandwich = Sandwich(context: self.managedObjectContext)
    newSandwich.name = sandwich.name
    newSandwich.sauceAmount = sandwich.sauceAmount.rawValue
    newSandwich.imageName = sandwich.imageName
    appDelegate.saveContext()
    tableView.reloadData()
  }

  
  @IBAction func presentAddView(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: "AddSandwichSegue", sender: self)
  }
  
  
  // MARK: - Search Controller
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  
  func filterContentForSearchText(_ searchText: String, sauceAmount: SauceAmount? = nil) {
    filteredSandwiches = sandwiches.filter { (sandwhich: SandwichData) -> Bool in
      let doesSauceAmountMatch = sauceAmount == .any || sandwhich.sauceAmount == sauceAmount

      return isSearchBarEmpty ? doesSauceAmountMatch : doesSauceAmountMatch && sandwhich.name.lowercased().contains(searchText.lowercased())
    }
    tableView.reloadData()
  }
  
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredSandwiches.count : sandwiches.count
  }

  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell else { return UITableViewCell() }
    
    let sandwich = isFiltering ? filteredSandwiches[indexPath.row] : sandwiches[indexPath.row]
    cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
    cell.nameLabel.text = sandwich.name
    cell.sauceLabel.text = sandwich.sauceAmount.description
    return cell
  }
}


// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let sauceAmount = SauceAmount(rawValue: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
  
}


// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
  
  func setupSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Filter Sandwiches"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
    searchController.searchBar.selectedScopeButtonIndex = lastFilterSelectedIndex
    searchController.searchBar.delegate = self
  }
  
  
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    lastFilterSelectedIndex = selectedScope
    let sauceAmount = SauceAmount(rawValue: searchBar.scopeButtonTitles![lastFilterSelectedIndex])
    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
  
}
