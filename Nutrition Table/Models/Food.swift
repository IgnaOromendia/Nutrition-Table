//
//  Alimento.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation

// Meal contains foods

class Food: CustomStringConvertible, Equatable, Comparable {
    private var name: String
    private var type: FoodType?
    
    var description: String {
        return "\(self.name)"
    }
    
    init(name: String, type: FoodType?) {
        self.name = name
        self.type = type
    }
    
    static func == (lhs: Food, rhs: Food) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func < (lhs: Food, rhs: Food) -> Bool {
        return lhs.name < rhs.name
    }
    
    func getName() -> String {
        return name
    }
    
    func getType() -> FoodType? {
        return type
    }
}

class Meal: Equatable {
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
    
    // Get all the food's names and return a string
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
    
    func deleteFood(_ food: Food) {
        for (index,item) in foods.enumerated() {
            if item == food {
                foods.remove(at: index)
            }
        }
    }
    
    func deleteAllFoods() {
        foods.removeAll()
    }
    
    func deleteLastFood() {
        foods.removeLast()
    }
    
}
