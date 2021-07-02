//
//  Meal.swift
//  Nutrition Table
//
//  Created by Igna on 01/07/2021.
//

import Foundation
import UIKit

class Meal: Equatable, Codable {
    private var foods: [Food]
    private var drink: String?
    
    init(foods: [Food] = [], drink: String? = nil) {
        self.drink = drink
        self.foods = foods
    }
    
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        return lhs.foods == rhs.foods
    }
    
    func addFood(_ food:Food){
        self.foods.append(food)
    }
    
    func addDrink(_ drink:String?) {
        self.drink = drink
    }
    
    func getFoodArray() -> [Food] {
        return self.foods
    }
    
    /// Get all food names and return a string
    func getFoodNames() -> String {
        if self.foods.count < 2 {
            return foods[0].getName()
        } else {
            var result: String = ""
            for food in foods {
                result += food == foods.last! ? "\(food)" : "\(food), "
            }
            return result
        }
    }
    
    /// Get all food names with their corresponding background as
    func getFoodNamesWithBackground() -> NSMutableAttributedString {
        if self.foods.count < 2 {
            let foodName = foods[0].getNameWithBackgorund()
            return NSMutableAttributedString(attributedString: foodName)
        } else {
            let result = NSMutableAttributedString()
            for food in foods {
                let name = NSMutableAttributedString(attributedString: food.getNameWithBackgorund())
                if food != foods.last! {
                    name.append(NSAttributedString(string: ", "))
                }
                result.append(name)
            }
            return result
        }
    }
    
    /// Get the predominant food type
    func getMajorFoodType() -> FoodType? {
        var foodTypes: (p:Int,c:Int,v:Int) = (0,0,0)
        
        for food in foods {
            switch food.getType() {
            case .protein:
                foodTypes.p += 1
            case .carbohydrates:
                foodTypes.c += 1
            case .vegetables:
                foodTypes.v += 1
            case .none:
                continue
            }
        }
        
        return getMaxFoodType(foodTypes)
    }
    
    // Delete
    
    /// Delete single food
    func deleteFood(_ food: Food) {
        for (index,item) in foods.enumerated() {
            if item == food {
                foods.remove(at: index)
            }
        }
    }
    
    func deleteFoodAt(_ i:Int) {
        foods.remove(at: i)
    }
 
    /// Delete all foods
    func deleteAllFoods() {
        foods.removeAll()
    }
    
    /// Delete last food
    func deleteLastFood() {
        foods.removeLast()
    }
    
    
    // Others
    
    private func getMaxFoodType(_ cantTypes: (p:Int,c:Int,v:Int)) -> FoodType? {
        let max = max(cantTypes.p, cantTypes.c, cantTypes.v)
        if max > 0 {
            if max == cantTypes.p {
                return .protein
            } else if max == cantTypes.c {
                return .carbohydrates
            } else if max == cantTypes.v {
                return .vegetables
            }
        }
        return nil
    }
    
}
