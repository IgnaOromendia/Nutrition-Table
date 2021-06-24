//
//  DayController.swift
//  Nutrition Table
//
//  Created by Igna on 18/06/2021.
//

import UIKit

class DayController: UITableViewController  {
    
    let allMeals: [TypeAndMeal]? = selectedDay.getAllMeals()
    
    override func viewDidLoad() {
        setNavigationBar(title: selectedDay.getDate().dayMonthDate, color: .white)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        cell.textLabel?.text = allMeals?[indexPath.section].meal.getFoodArray()[indexPath.row].getName()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return allMeals?[section].type.rawValue ?? "Error"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allMeals?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMeals?[section].meal.getFoodArray().count ?? 0
    }
    
    
    

}
