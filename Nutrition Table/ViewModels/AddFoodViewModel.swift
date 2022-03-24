//
//  AddFoodViewModel.swift
//  Nutrition Table
//
//  Created by Igna on 16/06/2021.
//

import Foundation
import UIKit

class AddFoodViewModel {
    
    static func setDoneButton(_ btn:UIButton) {
        btn.cornerRadius(of: 17)
        btn.titleLabel?.text = "Done"
        btn.titleLabel?.textColor = .white
    }
    
    static func setSegmentedControl(_ segmented:UISegmentedControl, _ type: inout FoodType?) {
        switch segmented.selectedSegmentIndex {
        case 0:
            segmented.selectedSegmentTintColor = .orangeC
            segmented.backgroundColor = .lightOrangeC
            type = .protein
        case 1:
            segmented.selectedSegmentTintColor = .yellow
            segmented.backgroundColor = .lightyellowC
            type = .carbohydrates
        case 2:
            segmented.selectedSegmentTintColor = .greenC
            segmented.backgroundColor = .lightGreenC
            type = .vegetables
        default:
            segmented.selectedSegmentTintColor = .white
            type = nil
        }
    }
    
    static func setFoodType(_ s:Int) -> FoodType? {
        if s == 0 {
            return .protein
        } else if s == 1 {
            return .carbohydrates
        } else if s == 2 {
            return .vegetables
        } else {
            return nil
        }
    }
    
    static func setViewSwitch(_ view:UIView, _ sw:UISwitch) {
        view.cornerRadius(of: 16)
        sw.onTintColor = .darkPurpleC
    }
    
    static func setTextView(_ textView:UITextView) {
        textView.clipsToBounds = false
        textView.shadow = true
    }
    
    static func addFood(name: String, type: FoodType?, _ foods: [Food]) throws -> Food {
        guard !name.isEmpty  else { throw AddFoodWarning.foodTextEmpty }
        let food = Food(name: name, type: type)
        guard !foods.contains(food) else { throw AddFoodWarning.alreadyContainsFood}
        return food
    }
    
    static func editExistingMeal(_ meal: inout Meal, moment: DayFoodType, in date:Date) {
        let day = Week.getDay(from: date)
        if let existingMeal = day?.getMeal(tipo: moment) {
            meal = existingMeal
        }
    }
    
    static func setRecomWordBtns(_ btns:[UIButton], at moment: DayFoodType) {
        let words = nutritionData.topMostEaten(at: moment)
        print(words)
        for i in 0...2 {
            btns[i].alpha = 0
            if words.count > i {
                btns[i].titleLabel?.text = words[i].getName()
                btns[i].alpha = 1
            }
            btns[i].cornerRadius(of: 10)
            btns[i].titleLabel?.textColor = .black
            btns[i].backgroundColor = .white
        }
    }
    
}
