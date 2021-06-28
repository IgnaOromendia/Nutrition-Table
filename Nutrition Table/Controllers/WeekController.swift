//
//  WeekController.swift
//  Nutrition Table
//
//  Created by Igna on 17/06/2021.
//

import UIKit

class WeekController: UITableViewController {
    
    private var weekDays: [WeekDay] = Date().getWeekDays()
    private var colors: [UIColor?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        setViewsColors()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekDays.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCellid", for: indexPath) as! DayCell
        cell.setCell(with: weekDays[indexPath.row], colors[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return weekCellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let day = Week.getDay(from: weekDays[indexPath.row].date) {
            selectedDay = day
            transition(to: dayId)
        }
    }
    
    private func setViewsColors() {
        for _ in weekDays {
            var randomColor: UIColor? = .randomColor()
            // agregar mas colores para amuentar las probabilidades
//            while (colors.contains(randomColor)) {
//                randomColor = .randomColor()
//            }
            colors.append(randomColor)
        }
    }
}
