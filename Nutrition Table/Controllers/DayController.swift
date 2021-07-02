//
//  DayController.swift
//  Nutrition Table
//
//  Created by Igna on 18/06/2021.
//

import UIKit

class DayController: UITableViewController  {
    
    @IBOutlet weak var btn_deleteAll: UIBarButtonItem!
    
    let stManager = StorgareManager()
    var allMeals = selectedDay.getMealsSorted(complete: false)
    
    lazy var onlyMeals: [Meal?] = {
        return allMeals.meal
    }()
    
    lazy var onlyTypes: [DayFoodType] = {
        var result: [DayFoodType] = []
        for ref in allMeals.ref {
            if let item = DayFoodType(rawValue: ref) {
                result.append(item)
            }
        }
        return result
    }()
    
    override func viewDidLoad() {
        DayViewModel.setDeleteAllBtn(btn_deleteAll, allMeals.meal.count)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        let text = onlyMeals[indexPath.section]?.getFoodArray()[indexPath.row].getName()
        cell.textLabel?.text = text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return onlyTypes[section].rawValue
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allMeals.meal.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onlyMeals[section]?.getFoodArray().count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let food = onlyMeals[indexPath.section]?.getFoodArray()[indexPath.row]
            let type = onlyTypes[indexPath.section]
            if let food = food {
                let title = deleteFoodTitle + food.getName()
                let message = deleteFoodMessage + food.getName()
                Alert.deletePopOver(title: title, message: message, in: self) {
                    DayViewModel.deleteFood(selectedDay.getDate(), type, food)
                    DayViewModel.setDeleteAllBtn(self.btn_deleteAll, self.allMeals.meal.count)
                    self.allMeals = selectedDay.getMealsSorted(complete: false)
                    self.tableView.reloadData()
                    self.stManager.saveWeekData(week: week)
                }
            }
        }
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        let title = deleteFoodTitle + "all meals"
        let message = deleteFoodMessage + "all meals"
        Alert.deletePopOver(title: title, message: message, in: self) {
            DayViewModel.deleteAll(selectedDay.getDate())
            DayViewModel.setDeleteAllBtn(self.btn_deleteAll, self.allMeals.meal.count)
            self.allMeals = selectedDay.getMealsSorted(complete: false)
            self.tableView.reloadData()
            self.stManager.saveWeekData(week: week)
        }
        tableView.reloadData()
    }
    

}
