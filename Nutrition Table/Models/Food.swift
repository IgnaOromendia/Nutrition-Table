//
//  Alimento.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation

class Food: CustomStringConvertible, Equatable, Comparable {
    var name: String
    var type: FoodType?
    
    var description: String {
        if let type = self.type {
            return "\(self.name) \(type)"
        } else {
            return "\(self.name)"
        }
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
}

class Meal {
    var foods: [Food]
    var drink: String?
    
    init(foods: [Food] = [], drink: String? = nil) {
        self.drink = drink
        self.foods = foods
    }
    
    func addFood(_ food:Food){
        self.foods.append(food)
    }
    
    func addDrink(_ drink:String?) {
        self.drink = drink
    }
    
    func contains(_ food: Food) -> Bool {
        var result = false
        for item in self.foods {
            if item == food {
                result = true
            }
        }
        return result
    }
    
}
