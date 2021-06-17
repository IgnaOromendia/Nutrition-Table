//
//  File.swift
//  Nutrition Table
//
//  Created by Igna on 16/06/2021.
//

import Foundation
import UIKit

class AddFoodViewModel {
    static func setDoneButton(_ btn:UIButton) {
        btn.redondeado(de: 17)
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
        view.redondeado(de: 16)
        sw.onTintColor = .darkPurpleC
    }
    
    static func setTextView(_ textView:UITextView) {
        textView.clipsToBounds = false
        textView.sombra = true
    }
    
    static func addFood(name: String, type: FoodType?, _ foods: [Food]) throws -> Food {
        guard !name.isEmpty  else { throw AddFoodWarningType.foodTextEmpty }
        let food = Food(name: name, type: type)
        guard !foods.contains(food) else { throw AddFoodWarningType.alreadyContainsFood}
        return food
    }
    
}
