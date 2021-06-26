//
//  Dia.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation

// A dat contains 6 meals and a date

class Day: CustomStringConvertible, Equatable {
    
    private var date: Date
    private var dayMeals: [String:Meal?]
    
    var description: String {
        var text = String()
        for (key,value) in dayMeals {
            text += "\(key): \(value?.getFoodNames() ?? "")\n"
        }
        return text
    }
    
    init(dayMeals:[String:Meal?], date:Date) {
        self.dayMeals = dayMeals
        self.date = date
    }
    
    convenience init(date:Date = Date()) {
        self.init(dayMeals: ["Breakfast":nil, "Snack1":nil, "Lunch":nil, "Snack2":nil, "Afternoon snack":nil, "Dinner":nil], date: date)
    }
    
    static func == (lhs: Day, rhs: Day) -> Bool {
        return lhs.date.comparableDate == rhs.date.comparableDate
    }
    
    func getDate() -> Date {
        return self.date
    }
    
    // Get a specific meal
    func getMeal(tipo: DayFoodType) -> Meal? {
        guard let meal = self.dayMeals[tipo.rawValue] else { return nil }
        return meal
    }
    
    // Get all the meals
    func getAllMeals() -> [String:Meal?] {
        return dayMeals
    }
    
    func getAllMealsWithoutNil() -> [String:Meal] {
        var meals: [String:Meal] = [:]
        for (key,value) in self.dayMeals {
            if let value = value {
                meals.updateValue(value, forKey: key)
            }
        }
        return meals
    }
    
    // Add a spceific meal
    func addMeal(_ meal:Meal, to moment:DayFoodType) throws {
        guard self.dayMeals[moment.rawValue] != meal else { throw AddMealWarning.alreadyContainsMeal}
        self.dayMeals.updateValue(meal, forKey: moment.rawValue)
    }
    
    
}
