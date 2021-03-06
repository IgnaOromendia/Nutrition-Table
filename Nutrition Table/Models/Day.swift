//
//  Dia.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation

// A dat contains 6 meals and a date

class Day: CustomStringConvertible, Equatable, Codable {
    
    private var date: Date
    private var dayMeals: [String:Meal?]
    private var sports: [String]
    
    var description: String {
        var text = String()
        for (key,value) in dayMeals {
            text += "\(key): \(value?.getFoodNames() ?? "")\n"
        }
        return text
    }
    
    init(dayMeals:[String:Meal?], date:Date, sports:[String]) {
        self.dayMeals = dayMeals
        self.date = date
        self.sports = sports
    }
    
    convenience init(date:Date = Date()) {
        self.init(dayMeals: ["Breakfast":nil, "Snack1":nil, "Lunch":nil, "Snack2":nil, "Afternoon snack":nil, "Dinner":nil], date: date, sports: [])
    }
    
    static func == (lhs: Day, rhs: Day) -> Bool {
        return lhs.date.comparableDate == rhs.date.comparableDate
    }
    
    // MARK: - GET
    
    /// Get date
    func getDate() -> Date {
        return self.date
    }
    
    /// Get a specific meal
    func getMeal(tipo: DayFoodType) -> Meal? {
        guard let meal = self.dayMeals[tipo.rawValue] else { return nil }
        return meal
    }
    
    /// Get all meals
    func getAllMeals() -> [String:Meal?] {
        return dayMeals
    }
    
    /// Get all meals added
    func getAllMealsWithoutNil() -> [String:Meal] {
        var meals: [String:Meal] = [:]
        for (key,value) in self.dayMeals {
            if let value = value {
                meals.updateValue(value, forKey: key)
            }
        }
        return meals
    }
    
    /// Get all meals sorted by the moment
    /// - Parameter complete: if true then the array will containg nil elements
    /// - Returns: if complete is true then will return 6 meals with nils included in case meals no exists
    func getMealsSorted(complete: Bool) -> (ref: [String],meal: [Meal?]) {
        return self.momentSort(complete: complete)
    }
    
    /// Get the predominant food type
    func getPredominantMealFoodType() -> FoodType? {
        var foodTypes: (p:Int,c:Int,v:Int) = (0,0,0)
        
        for meal in self.dayMeals {
            let foodType = meal.value?.getMajorFoodType()
            switch foodType {
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
    
    /// Get sports
    func getSports() -> [String] {
        return self.sports
    }
    
    /// Get only meals that contain some food
    private func cleanMeals(_ meals: (ref: [String],meal: [Meal?])) ->(ref: [String],meal: [Meal]) {
        var newMeals: (ref: [String],meal: [Meal]) = ([],[])
        for i in 0...meals.ref.count - 1 {
            if let meal = meals.meal[i] {
                newMeals.meal.append(meal)
                newMeals.ref.append(meals.ref[i])
            }
            
        }
        return newMeals
    }
    
    /// Get maximum of food types
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
    
    // MARK: - SET
    
    /// Add a spceific meal
    func addMeal(_ meal:Meal, to moment:DayFoodType) {
        //Nunca llega a este guard
        //guard self.dayMeals[moment.rawValue] != meal else { throw AddMealWarning.alreadyContainsMeal}
        self.dayMeals.updateValue(meal, forKey: moment.rawValue)
    }
    
    /// Add sport
    func addSport(_ sport:String) {
        self.sports.append(sport)
    }
    
    // MARK: - DELETE
    
    /// Delete meal at moment
    func deleteMeal(_ moment:DayFoodType) {
        self.dayMeals.updateValue(nil, forKey: moment.rawValue)
    }
    
    /// Delete all meals
    func deleteAllMeals() {
        for (key,_) in self.dayMeals {
            self.dayMeals.updateValue(nil, forKey: key)
        }
    }
    
    /// Delete sport at index
    func deleteSport(at index:Int) {
        self.sports.remove(at: index)
    }
    
    /// Delete all sports
    func deleteAllSports() {
        self.sports.removeAll()
    }
    
    /// Delete the sport with the given name
    func deleteSport(withName sportToDelete: String) {
        for (index,sport) in sports.enumerated() {
            if sport == sportToDelete {
                deleteSport(at: index)
            }
        }
    }
    
    // MARK: - OTHERS
    
    /// Sort from breakfast to dinner
    private func momentSort(complete: Bool) -> (ref: [String],meal: [Meal?]) {
        var sortedMeals: (ref: [String],meal: [Meal?]) = (Array(repeating: "", count: 6),Array(repeating: nil, count: 6))
        for (key,value) in self.dayMeals {
            switch key {
            case "Breakfast":
                sortedMeals.ref[0] = key
                sortedMeals.meal[0] = value
            case "Snack1":
                sortedMeals.ref[1] = key
                sortedMeals.meal[1] = value
            case "Lunch":
                sortedMeals.ref[2] = key
                sortedMeals.meal[2] = value
            case "Snack2":
                sortedMeals.ref[3] = key
                sortedMeals.meal[3] = value
            case "Afternoon snack":
                sortedMeals.ref[4] = key
                sortedMeals.meal[4] = value
            case "Dinner":
                sortedMeals.ref[5] = key
                sortedMeals.meal[5] = value
            default:
                print("Error moment sort")
            }
        }
        
        return complete ? sortedMeals : cleanMeals(sortedMeals)
    }
    
}
