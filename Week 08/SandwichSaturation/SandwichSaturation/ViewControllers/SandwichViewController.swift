//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
import UIKit


protocol SandwichDataSource {
  func saveSandwich(_: SandwichData)
}


class SandwichViewController: UITableViewController {
  
  private var sandwiches = [Sandwich]()
  private var filteredSandwiches = [Sandwich]()
  private let searchController = UISearchController(searchResultsController: nil)
  private let coreDataManager = CoreDataManager()


  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupSearchController()
    setupSandwiches()
  }
  
  
  func setupSandwiches() {
    sandwiches = coreDataManager.fetchSandwiches()
    sandwiches = sandwiches.isEmpty ? coreDataManager.saveSandwichesFromJSONToCoreData() : sandwiches
  }
  

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let viewController = segue.destination as? AddSandwichViewController else { return }
    viewController.delegate = self
  }
  
  
  @IBAction func sortSandwichesTapped(_ sender: SortingBarButtonItem) {
    UserSettings.sortingSelection.toggle()
    sender.updateSortingImageButton()
    sandwiches = coreDataManager.sorted(sandwiches, by: UserSettings.sortingSelection)
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
      coreDataManager.delete(selectedSandwich)
      sandwiches = coreDataManager.fetchSandwiches()
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    let sandwich = isFiltering ? filteredSandwiches[indexPath.row] : sandwiches[indexPath.row]
    
    return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
      
      let oneStar = UIAction(title: "★☆☆☆☆", image: UIImage(systemName: "1.circle")) { action in
        self.coreDataManager.edit(sandwich, 1.0)
        self.sandwiches = self.coreDataManager.fetchSandwiches()
        tableView.reloadData()
      }
      
      let twoStars = UIAction(title: "★★☆☆☆", image: UIImage(systemName: "2.circle")) { action in
        self.coreDataManager.edit(sandwich, 2.0)
        self.sandwiches = self.coreDataManager.fetchSandwiches()
        tableView.reloadData()
      }
      
      let threeStars = UIAction(title: "★★★☆☆", image: UIImage(systemName: "3.circle")) { action in
        self.coreDataManager.edit(sandwich, 3.0)
        self.sandwiches = self.coreDataManager.fetchSandwiches()
        tableView.reloadData()
      }
      
      let fourStars = UIAction(title: "★★★★☆", image: UIImage(systemName: "4.circle")) { action in
        self.coreDataManager.edit(sandwich, 4.0)
        self.sandwiches = self.coreDataManager.fetchSandwiches()
        tableView.reloadData()
      }
      
      let fiveStars = UIAction(title: "★★★★★", image: UIImage(systemName: "5.circle")) { action in
        self.coreDataManager.edit(sandwich, 5.0)
        self.sandwiches = self.coreDataManager.fetchSandwiches()
        tableView.reloadData()
      }
      
      return UIMenu(title: "Rating", children: [fiveStars, fourStars, threeStars, twoStars, oneStar])
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
