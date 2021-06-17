//
//  DayCell.swift
//  Nutrition Table
//
//  Created by Igna on 17/06/2021.
//

import UIKit

class DayCell: UITableViewCell {
    
    @IBOutlet weak var view_day: UIView!
    @IBOutlet weak var circleView_FoodType: UIView!
    
    @IBOutlet weak var lbl_breakfast: UILabel!
    @IBOutlet weak var lbl_lunch: UILabel!
    @IBOutlet weak var lbl_dinner: UILabel!
    @IBOutlet weak var lbl_day: UILabel!
    
    @IBOutlet weak var im_breakfast: UIImageView!
    @IBOutlet weak var im_lunch: UIImageView!
    @IBOutlet weak var im_dinner: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(with weekDay:WeekDay) {
        self.selectionStyle = .none
        view_day.redondeado(de: 30)
        circleView_FoodType.circle = true
        setFoodLabels(weekDay)
        lbl_day.text = weekDay.dateDay
    }
    
    private func setFoodLabels(_ weekDay:WeekDay) {
        if let day = WeekViewModel.setDay(from: weekDay.date) {
            if let breakfast = day.breakfast {
                lbl_breakfast.text = breakfast.getFoods()
            } else {
                lbl_breakfast.text = "No breakfast added"
            }
            
            if let lunch = day.lunch {
                lbl_lunch.text = lunch.getFoods()
            } else {
                lbl_lunch.text = "No lunch added"
            }
            
            if let dinner = day.dinner {
                lbl_dinner.text = dinner.getFoods()
            } else {
                lbl_dinner.text = "No dinner added"
            }
        } else {
            setDefaultValues()
        }
    }
    
    private func setDefaultValues() {
        lbl_breakfast.text = "No breakfast added"
        lbl_lunch.text = "No lunch added"
        lbl_dinner.text = "No dinner added"
    }

}
