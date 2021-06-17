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
    
    static func setSegmentedControl(_ segmented:UISegmentedControl) {
        switch segmented.selectedSegmentIndex {
        case 0:
            segmented.selectedSegmentTintColor = .orangeC
            segmented.backgroundColor = .lightOrangeC
        case 1:
            segmented.selectedSegmentTintColor = .yellow
            segmented.backgroundColor = .lightyellowC
        case 2:
            segmented.selectedSegmentTintColor = .greenC
            segmented.backgroundColor = .lightGreenC
        default:
            segmented.selectedSegmentTintColor = .white
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
    
    static func addFood(to meal: inout Meal, name: String, type: FoodType?) throws {
        guard name != ""  else { throw AddFoodWarningType.foodTextEmpty }
        meal.addFood(Food(name: name, type: type))
    }
    
}
