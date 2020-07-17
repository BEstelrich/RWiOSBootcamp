//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
import UIKit
//import CoreData


protocol SandwichDataSource {
  func saveSandwich(_: SandwichData)
}


class SandwichViewController: UITableViewController {
  
  @IBOutlet weak var sortingSandwichesButton: UIBarButtonItem!
  
  private let searchController = UISearchController(searchResultsController: nil)
  private var sandwiches = [Sandwich]()
  private var filteredSandwiches = [Sandwich]()
  private let coreDataManager = CoreDataManager()


  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupSearchController()
    setupSandwiches()
  }

  
  func setupSandwiches() {
    sandwiches = coreDataManager.fetchSandwiches()
    
    if sandwiches.isEmpty {
      sandwiches = coreDataManager.saveSandwichesFromJSONToCoreData()
    }
  }
  

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let viewController = segue.destination as? AddSandwichViewController else { return }
    viewController.delegate = self
  }
  
  
  @IBAction func sortSandwichesTapped(_ sender: UIBarButtonItem) {
    switch sender.title {
    case "Name":
      sortingSandwichesButton.title = "Sauce amount"
      UserSettings.sortingSelection = "Sauce amount"
    case "Sauce Amount":
      sortingSandwichesButton.title = "Name"
      UserSettings.sortingSelection = "Name"
    default:
      sortingSandwichesButton.title = "Name"
      UserSettings.sortingSelection = "Name"
    }
    sandwiches = coreDataManager.fetchSandwiches()
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
    filteredSandwiches = sandwiches.filter { (sandwhich: Sandwich) -> Bool in
      let doesSauceAmountMatch = sauceAmount == .any || sandwhich.sauceAmount == sauceAmount!.rawValue

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
  
  
  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }

  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredSandwiches.count : sandwiches.count
  }

  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SandwichCell.reuseIdentifier, for: indexPath) as? SandwichCell else { return UITableViewCell() }
    
    let sandwich = isFiltering ? filteredSandwiches[indexPath.row] : sandwiches[indexPath.row]
    cell.populate(with: sandwich)
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let selectedSandwich = sandwiches[indexPath.row]
      sandwiches.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
      coreDataManager.delete(selectedSandwich)
    }
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
    searchController.searchBar.selectedScopeButtonIndex = UserSettings.lastFilterSelectedIndex
    searchController.searchBar.delegate = self
  }
  
  
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    UserSettings.lastFilterSelectedIndex = selectedScope
    let sauceAmount = SauceAmount(rawValue: searchBar.scopeButtonTitles![UserSettings.lastFilterSelectedIndex])
    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
  
}


// MARK: - SandwichDataSource
extension SandwichViewController: SandwichDataSource {
  
  func saveSandwich(_ sandwich: SandwichData) {
    coreDataManager.save(sandwich)
    sandwiches = coreDataManager.fetchSandwiches()
    tableView.reloadData()
  }
  
}
