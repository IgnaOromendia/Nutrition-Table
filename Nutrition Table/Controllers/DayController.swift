//
//  DayController.swift
//  Nutrition Table
//
//  Created by Igna on 18/06/2021.
//

import UIKit

class DayController: UITableViewController  {
    
    @IBOutlet weak var btn_deleteAll: UIBarButtonItem!
    
    private let stManager = StorgareManager()
    private var allMeals = selectedDay.getMealsSorted(complete: false)
    
    lazy private var daySports: [String] = {
        return updateSports()
    }()
    
    lazy private var onlyMeals: [Meal?] = {
        return updateMeals()
    }()
    
    lazy private var onlyTypes: [DayFoodType] = {
        return updateTypes()
    }()
    
    override func viewDidLoad() {
        DayViewModel.setDeleteAllBtn(btn_deleteAll, allMeals.meal.count + daySports.count)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateAllValues()
        tableView.reloadData()
    }
    
    // MARK: - TABLEVIEW
    
    // SECTION
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == allMeals.meal.count ? "Day's sports" : onlyTypes[section].rawValue
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allMeals.meal.count + 1
    }
    
    // ROW
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section != allMeals.meal.count ? onlyMeals[section]?.getFoodArray().count ?? 0 : daySports.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        let text = indexPath.section != allMeals.meal.count ? onlyMeals[indexPath.section]?.getFoodArray()[indexPath.row].getName() : daySports[indexPath.row]
        cell.textLabel?.text = text
        cell.selectionStyle = .none
        return cell
    }
    
    // EDITING
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != allMeals.meal.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let food = onlyMeals[indexPath.section]?.getFoodArray()[indexPath.row]
            let type = onlyTypes[indexPath.section]
            if let food = food {
                let title = deleteTitle + food.getName()
                let message = deleteMessage + food.getName()
                Alert.deletePopOver(title: title, message: message, in: self) {
                    DayViewModel.deleteFood(selectedDay.getDate(), type, food)
                    DayViewModel.setDeleteAllBtn(self.btn_deleteAll, self.allMeals.meal.count)
                    nutritionData.updateWeek(week: currentWeek)
                    self.allMeals = selectedDay.getMealsSorted(complete: false)
                    self.tableView.reloadData()
                    self.stManager.saveData(data: nutritionData)
                }
            }
        }
    }
    
    // SELECTION
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == allMeals.meal.count {
            transition(to: sportsid)
        }
    }
    
    // MARK: - ACTIONS
    
    @IBAction func deleteAll(_ sender: Any) {
        let title = deleteTitle + "all meals"
        let message = deleteMessage + "all meals"
        Alert.deletePopOver(title: title, message: message, in: self) {
            DayViewModel.deleteAll(selectedDay.getDate())
            DayViewModel.setDeleteAllBtn(self.btn_deleteAll, self.allMeals.meal.count)
            nutritionData.updateWeek(week: currentWeek)
            self.allMeals = selectedDay.getMealsSorted(complete: false)
            self.tableView.reloadData()
            self.stManager.saveData(data: nutritionData)
        }
        tableView.reloadData()
    }
    
    @IBAction func addMeal(_ sender: Any) {
        transition(to: chooseid)
    }
    
    // MARK: - OTHERS
    
    private func updateAllValues() {
        allMeals = selectedDay.getMealsSorted(complete: false)
        daySports = updateSports()
        onlyMeals = updateMeals()
        onlyTypes = updateTypes()
    }
    
    private func updateMeals() -> [Meal?] {
        return allMeals.meal
    }
    
    private func updateTypes() -> [DayFoodType] {
        var result: [DayFoodType] = []
        for ref in allMeals.ref {
            if let item = DayFoodType(rawValue: ref) {
                result.append(item)
            }
        }
        return result
    }
    
    private func updateSports() -> [String] {
        return selectedDay.getSports().isEmpty ? ["Add Sport"] : selectedDay.getSports()
    }
    
    
    
}
