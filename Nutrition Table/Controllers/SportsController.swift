//
//  SportsController.swift
//  Nutrition Table
//
//  Created by Igna on 03/07/2021.
//

import UIKit

class SportsController: UITableViewController, UISearchBarMethdos {
    
    private let searchBarController = UISearchController(searchResultsController: nil)
    private let sectionTitles = ["\(selectedDay.getDate().prettyDate) sports", "Sports"]
    
    private var sports = SportsViewModel.getSports()
    private var sportsSelected = [String]()
    private var filteredSports = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSearchBar(for: searchBarController, hides: false, obscure: false, placeholder: "Search your sport")
        sportsSelected = selectedDay.getSports()
    }
    
    // MARK: - TABLE VIEW
    
    // EDITING
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 && sportsSelected.count > 0
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let title = deleteTitle + sportsSelected[indexPath.row]
            let message = deleteMessage + sportsSelected[indexPath.row]
            Alert.deletePopOver(title: title, message: message, in: self) {
                SportsViewModel.removeSportFromDay(self.sportsSelected[indexPath.row], to: selectedDay.getDate())
                self.sportsSelected.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    // SECTION
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sportsSelected.isEmpty ? 1 : 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sportsSelected.isEmpty ? sectionTitles[1] : sectionTitles[section]
    }
    
    // ROW
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRow = searchBarController.isFiltering ? [sportsSelected.count,filteredSports.count] : [sportsSelected.count,sports.count]
        return sportsSelected.isEmpty ? numberOfRow[1] : numberOfRow[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "sportCellid")
        let generalArr = searchBarController.isFiltering ? [sportsSelected,filteredSports] : [sportsSelected,sports]
        cell.selectionStyle = .none
        cell.textLabel?.text = sportsSelected.isEmpty ? generalArr[1][indexPath.row] : generalArr[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 || (indexPath.section == 0 && sportsSelected.count == 0) {
            let title = searchBarController.isFiltering ? addTitle + filteredSports[indexPath.row] : addTitle + sports[indexPath.row]
            let message = searchBarController.isFiltering ? addMessage + filteredSports[indexPath.row] : addMessage + sports[indexPath.row]
            var trainingTime = String()
            Alert.addTextFieldPopOver(title: title, message: message, in: self) { text in
                if let text = text {
                    trainingTime = text
                }
                let sport = self.searchBarController.isFiltering ? self.filteredSports[indexPath.row] : self.sports[indexPath.row]
                let sportToAdd = "\(sport), (\(trainingTime))"
                self.sportsSelected.append(sportToAdd)
                SportsViewModel.addToDaySports(sportToAdd, to: selectedDay.getDate())
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - SEARCH BAR
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredSports = SportsViewModel.filterContentForSearchText(searchController.searchBar.text!, sports: sports, sportsAdded: sportsSelected)
        tableView.reloadData()
    }
    

}
