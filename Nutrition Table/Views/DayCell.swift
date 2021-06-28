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

    /// Cell genereated in the week view
    func setCell(with weekDay:WeekDay, _ color: UIColor?) {
        self.selectionStyle = .none
        view_day.cornerRadius(de: 25)
        view_day.backgroundColor = color
        circleView_FoodType.circle = true
        setFoodLabels(weekDay)
        setImages()
        lbl_day.text = weekDay.dateDay + ", " + weekDay.date.dayMonthDate
        setCircleViewColor(weekDay)
    }

    private func setImages() {
        im_lunch.image = UIImage(named: "Sun2.png")
        im_dinner.image = UIImage(named: "Moon2.png")
        im_breakfast.image = UIImage(named: "Sunrise2.png")
    }

    private func setFoodLabels(_ weekDay:WeekDay) {
        if let day = Week.getDay(from: weekDay.date) {
            if let breakfast = day.getMeal(tipo: .breakfast) {
                lbl_breakfast.text = breakfast.getFoodNames()
            } else {
                lbl_breakfast.text = "No breakfast added"
            }

            if let lunch = day.getMeal(tipo: .lunch) {
                lbl_lunch.text = lunch.getFoodNames()
            } else {
                lbl_lunch.text = "No lunch added"
            }

            if let dinner = day.getMeal(tipo: .dinner) {
                lbl_dinner.text = dinner.getFoodNames()
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
        circleView_FoodType.alpha = 0;
    }
    
    private func setCircleViewColor(_ weekDay: WeekDay) {
        if let day = Week.getDay(from: weekDay.date) {
            if let predominantType = day.getPredominantMealFoodType() {
                switch predominantType {
                case .protein:
                    circleView_FoodType.backgroundColor = .orangeC
                case .carbohydrates:
                    circleView_FoodType.backgroundColor = .yellow
                case .vegetables:
                    circleView_FoodType.backgroundColor = .greenC
                }
            } else {
                circleView_FoodType.backgroundColor = .white
            }
        }
    }

}

