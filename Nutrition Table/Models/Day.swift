//
//  Dia.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation

class Day: CustomStringConvertible {
    var date: Date
    var breakfast: Meal?
    var snaks: Snaks?
    var lunch: Meal?
    var dinner: Meal?
    var afternoonSnack: Meal?
    
    var description: String {
        return """
            Breakfast: \(breakfast?.foods ?? [])
            Snack1: \(snaks?.s1.foods ?? [])
            Snack2: \(snaks?.s2.foods ?? [])
            Lunch: \(lunch?.foods ?? [])
            Afternoon: \(afternoonSnack?.foods ?? [])
            Dinner: \(dinner?.foods ?? [])
        """
    }
    
    init(breakfast:Meal?, snaks:Snaks?,lunch:Meal?,dinner:Meal?, afternoonSnak:Meal?, date:Date) {
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
        self.afternoonSnack = afternoonSnak
        self.snaks = snaks
        self.date = date
    }
    
    convenience init(date:Date = Date()) {
        self.init(breakfast:nil, snaks:nil,lunch:nil,dinner:nil, afternoonSnak:nil, date: date)
    }
    
    func getFood(tipo: DayFoodType) -> Meal? {
        switch tipo {
        case .breakfast:
            guard let breakfast = self.breakfast else {return nil}
            return breakfast
        case .lunch:
            guard let lunch = self.lunch else {return nil}
            return lunch
        case .snack1:
            guard let snak1 = self.snaks?.s1 else {return nil}
            return snak1
        case .snack2:
            guard let snak1 = self.snaks?.s2 else {return nil}
            return snak1
        case .afternoonSnack:
            guard let afternoonSnak = self.afternoonSnack else {return nil}
            return afternoonSnak
        case .dinner:
            guard let dinner = self.dinner else {return nil}
            return dinner
        }
    }
    
    
    func getAllFoods() -> [DayFoodType:Meal]? {
        var Foods:[DayFoodType:Meal] = [:]
        
        if let breakfast = self.breakfast {
            Foods[DayFoodType.breakfast] = breakfast
        }
        
        if let lunch = self.lunch {
            Foods[DayFoodType.lunch] = lunch
        }
        
        if let dinner = self.dinner {
            Foods[DayFoodType.dinner] = dinner
        }
        
        if let afternoonSnak = self.afternoonSnack {
            Foods[DayFoodType.afternoonSnack] = afternoonSnak
        }
        
        // Faltan los snaks
        
        return Foods.count > 0 ? Foods : nil
    }
    
    func addMeal(_ meal:Meal, to moment:DayFoodType) throws {
        switch moment {
        case .breakfast:
            guard self.breakfast != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.breakfast = meal
        case .lunch:
            guard self.lunch != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.lunch = meal
        case .snack1:
            guard self.snaks?.s1 != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.snaks?.s1 = meal
        case .snack2:
            guard self.snaks?.s2 != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.snaks?.s2 = meal
        case .afternoonSnack:
            guard self.afternoonSnack != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.afternoonSnack = meal
        case .dinner:
            guard self.dinner != meal else { throw AddMealWarning.alreadyContainsMeal }
            self.dinner = meal
        }
    }
    
    
    
}
