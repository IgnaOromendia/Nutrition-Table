//
//  Week.swift
//  Nutrition Table
//
//  Created by Igna on 17/06/2021.
//

import Foundation

class Week {
    var days: [Day]
    private var todayIndex: Int? {
        get {
            for (i,day) in days.enumerated() {
                if day.date.comparableDate == Date.today {
                    return i
                }
            }
            return nil
        }
    }
    
    init(days: [Day] = []) {
        self.days = []
        self.days = days.count > 0 ? days : generateWeek()
    }
    
    private func generateWeek() -> [Day] {
        let distanceMonday = Date().getDistanceMonday()
        var days: [Day] = []
        
        for i in 0..<distanceMonday {
            let day = Day(date: Date() - TimeInterval((84600 * i)))
            days.append(day)
        }
        
        return days
    }
    
    func addMealToday(_ meal: Meal, in moment:DayFoodType) throws {
        let index = self.todayIndex
        guard index != nil else { throw AddMealWarning.todayError }
        do {
            try self.days[index!].addMeal(meal, to: moment)
            print("se agrego con exito")
        } catch {
            throw AddMealWarning.alreadyContainsMeal
        }
    }
    
}
