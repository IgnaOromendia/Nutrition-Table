//
//  Week.swift
//  Nutrition Table
//
//  Created by Igna on 17/06/2021.
//

import Foundation

class Week: Codable {
    var days: [Day]
    
    private var id: String = ""
    private var todayIndex: Int? {
        get {
            for (i,day) in days.enumerated() {
                if day.getDate().comparableDate == Date.today {
                    return i
                }
            }
            return nil
        }
    }
    
    init(days: [Day] = []) {
        self.days = []
        self.days = days.count > 0 ? days : generateWeek()
        generateID()
    }
    
    private func generateID() {
        guard let lastDay = self.days.last else {return}
        self.id = lastDay.getDate().storageDate + "-Monday"
    }
    
    func getID() -> String {
        return self.id
    }
    
    /// Generate a week form today to monday from the same week
    private func generateWeek() -> [Day] {
        let distanceMonday = Date().getDistanceMonday()
        var days: [Day] = []
        for i in 0..<distanceMonday {
            let day = Day(date: Date() - TimeInterval((84600 * i)))
            days.append(day)
        }
        
        return days
    }
    
    /// Add meal today
    func addMealToday(_ meal: Meal, in moment:DayFoodType) throws {
        let index = self.todayIndex
        guard index != nil else { throw AddMealWarning.todayError }
        guard !meal.getFoodArray().isEmpty else {throw AddMealWarning.foodArrayEmpty}
        do {
            try self.days[index!].addMeal(meal, to: moment)
            print("se agrego con exito")
        } catch {
            throw AddMealWarning.alreadyContainsMeal
        }
    }
    
    /// Returns today
    static func getDay(from weekDay:Date) -> Day? {
        for day in week.days {
            if (day.getDate().comparableDate == weekDay.comparableDate) {
                return day
            }
        }
        return nil
    }
    
}
