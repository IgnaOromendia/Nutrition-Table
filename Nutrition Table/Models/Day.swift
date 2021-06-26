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
    private var breakfast: Meal?
    private var snack1: Meal?
    private var snack2: Meal?
    private var lunch: Meal?
    private var dinner: Meal?
    private var afternoonSnack: Meal?
    
    var description: String {
        return """
            Breakfast: \(breakfast?.getFoodNames() ?? "")
            Snack1: \(snack1?.getFoodNames() ?? "")
            Snack2: \(snack2?.getFoodNames() ?? "")
            Lunch: \(lunch?.getFoodNames() ?? "")
            Afternoon: \(afternoonSnack?.getFoodNames() ?? "")
            Dinner: \(dinner?.getFoodNames() ?? "")
        """
    }
    
    init(breakfast:Meal?, snack1:Meal?, snack2:Meal? ,lunch:Meal?,dinner:Meal?, afternoonSnak:Meal?, date:Date) {
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
        self.afternoonSnack = afternoonSnak
        self.snack1 = snack1
        self.snack2 = snack2
        self.date = date
    }
    
    convenience init(date:Date = Date()) {
        self.init(breakfast:nil, snack1:nil, snack2:nil, lunch:nil, dinner:nil, afternoonSnak:nil, date: date)
    }
    
    static func == (lhs: Day, rhs: Day) -> Bool {
        return lhs.date.comparableDate == rhs.date.comparableDate
    }
    
    func getDate() -> Date {
        return self.date
    }
    
    // Get a specific meal
    func getMeal(tipo: DayFoodType) -> Meal? {
        switch tipo {
        case .breakfast:
            guard let breakfast = self.breakfast else {return nil}
            return breakfast
        case .lunch:
            guard let lunch = self.lunch else {return nil}
            return lunch
        case .snack1:
            guard let snak1 = self.snack1 else {return nil}
            return snak1
        case .snack2:
            guard let snak2 = self.snack2 else {return nil}
            return snak2
        case .afternoonSnack:
            guard let afternoonSnak = self.afternoonSnack else {return nil}
            return afternoonSnak
        case .dinner:
            guard let dinner = self.dinner else {return nil}
            return dinner
        }
    }
    
    // Get all the meals
    func getAllMeals() -> [TypeAndMeal]? {
        
        var meals:[TypeAndMeal] = []
        
        if let breakfast = self.breakfast {
            let mealToAdd:TypeAndMeal = (.breakfast, breakfast)
            meals.append(mealToAdd)
        }
        
        if let snack1 = self.snack1 {
            let snack1ToAdd:TypeAndMeal = (.snack1, snack1)
            meals.append(snack1ToAdd)
        }
        
        if let lunch = self.lunch {
            let mealToAdd:TypeAndMeal = (.lunch, lunch)
            meals.append(mealToAdd)
        }
        
        if let snack2 = self.snack2 {
            let snack2ToAdd:TypeAndMeal = (.snack2, snack2)
            meals.append(snack2ToAdd)
        }
        
        if let afternoonSnack = self.afternoonSnack {
            let mealToAdd:TypeAndMeal = (.afternoonSnack, afternoonSnack)
            meals.append(mealToAdd)
        }
        
        
        if let dinner = self.dinner {
            let mealToAdd:TypeAndMeal = (.dinner, dinner)
            meals.append(mealToAdd)
        }
        
        return meals.count > 0 ? meals : nil
    }
    
    // Add a spceific meal
    func addMeal(_ meal:Meal, to moment:DayFoodType) throws {
        switch moment {
        case .breakfast:
            guard self.breakfast != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.breakfast = meal
        case .lunch:
            guard self.lunch != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.lunch = meal
        case .snack1:
            guard self.snack1 != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.snack1 = meal
        case .snack2:
            guard self.snack2 != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.snack2 = meal
        case .afternoonSnack:
            guard self.afternoonSnack != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.afternoonSnack = meal
        case .dinner:
            guard self.dinner != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.dinner = meal
        }
    }
    
    
}
