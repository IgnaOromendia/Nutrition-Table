//
//  WeekController.swift
//  Nutrition Table
//
//  Created by Igna on 17/06/2021.
//

import UIKit

class WeekController: UITableViewController {
    
    var weekDays: [WeekDay] = Date().getWeekDays()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekDays.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCellid", for: indexPath) as! DayCell
        cell.setCell(with: weekDays[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 204
    }
    
    
    
    
}
