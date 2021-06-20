//
//  Dia.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation

// A dat contains 6 meals and a date

class Day: CustomStringConvertible {
    private var date: Date
    private var breakfast: Meal?
    private var snacks: Snaks?
    private var lunch: Meal?
    private var dinner: Meal?
    private var afternoonSnack: Meal?
    
    var description: String {
        return """
            Breakfast: \(breakfast?.getFoodNames() ?? "")
            Snack1: \(snacks?.s1.getFoodNames() ?? "")
            Snack2: \(snacks?.s2.getFoodNames() ?? "")
            Lunch: \(lunch?.getFoodNames() ?? "")
            Afternoon: \(afternoonSnack?.getFoodNames() ?? "")
            Dinner: \(dinner?.getFoodNames() ?? "")
        """
    }
    
    init(breakfast:Meal?, snaks:Snaks?,lunch:Meal?,dinner:Meal?, afternoonSnak:Meal?, date:Date) {
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
        self.afternoonSnack = afternoonSnak
        self.snacks = snaks
        self.date = date
    }
    
    convenience init(date:Date = Date()) {
        self.init(breakfast:nil, snaks:nil,lunch:nil,dinner:nil, afternoonSnak:nil, date: date)
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
            guard let snak1 = self.snacks?.s1 else {return nil}
            return snak1
        case .snack2:
            guard let snak1 = self.snacks?.s2 else {return nil}
            return snak1
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
        
        if let lunch = self.lunch {
            let mealToAdd:TypeAndMeal = (.lunch, lunch)
            meals.append(mealToAdd)
        }
        
        if let dinner = self.dinner {
            let mealToAdd:TypeAndMeal = (.dinner, dinner)
            meals.append(mealToAdd)
        }
        
        if let afternoonSnack = self.afternoonSnack {
            let mealToAdd:TypeAndMeal = (.afternoonSnack, afternoonSnack)
            meals.append(mealToAdd)
        }
        
        // Faltan los snaks
        
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
            guard self.snacks?.s1 != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.snacks?.s1 = meal
        case .snack2:
            guard self.snacks?.s2 != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.snacks?.s2 = meal
        case .afternoonSnack:
            guard self.afternoonSnack != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.afternoonSnack = meal
        case .dinner:
            guard self.dinner != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.dinner = meal
        }
    }
    
    
    
}
