//
//  Alimento.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation

class Food: CustomStringConvertible, Equatable, Comparable {
    var name: String
    var type: FoodType
    
    var description: String {
        return "\(self.name) \(self.type)"
    }
    
    init(name: String, type: FoodType) {
        self.name = name
        self.type = type
    }
    
    static func == (lhs: Food, rhs: Food) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type
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
    
    func addFood(_ alimento:Food){
        self.foods.append(alimento)
    }
    
    func addDrink(_ bebida:String?) {
        self.drink = bebida
    }
}
