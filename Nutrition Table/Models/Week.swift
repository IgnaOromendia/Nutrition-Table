//
//  Week.swift
//  Nutrition Table
//
//  Created by Igna on 17/06/2021.
//

import Foundation

class Week: Codable {
    
    private var days: [Day]
    private var id: String
    
    /// Get today Day
    var today: Day? {
        get {
            return Week.getDay(from: Date())
        }
    }
    
    init(days: [Day] = []) {
        self.days = []
        self.days = days
        self.id = ""
    }
    
    // MARK: - GET
    
    func getID() -> String {
        return self.id
    }
    
    /// Get all days
    func getAllDays() -> [Day] {
        return self.days
    }
    
    /// Get specific day
    static func getDay(from weekDay:Date) -> Day? {
        for day in week.days {
            if (day.getDate().comparableDate == weekDay.comparableDate) {
                return day
            }
        }
        return nil
    }
    
    /// Get a day index
    private static func dayIndex(_ dayI:Day) -> Int? {
        for (index,day) in week.days.enumerated() {
            if day == dayI {
                return index
            }
        }
        return nil
    }
    
    // MARK: - SET
    
    /// Set all days
    func setDays(with days2: [Day]) {
        self.days = days2
    }
    
    /// Set a day at index
    func setDay(at index:Int, _ day: Day) {
        self.days[index] = day
    }
    
    /// Set meal
    func addMeal(_ meal: Meal, in moment:DayFoodType, to date: Date) throws {
        guard let day = Week.getDay(from: date) else {throw AddMealWarning.dayError}
        guard let dayIndex = Week.dayIndex(day) else {throw AddMealWarning.indexError}
        guard !meal.getFoodArray().isEmpty else {throw AddMealWarning.foodArrayEmpty}
        self.days[dayIndex].addMeal(meal, to: moment)
    }
    
    /// Update all values from a week
    func updateValues(with savedWeek: Week) {
        if week.days.count == savedWeek.days.count {
            week = savedWeek
        } else if week.days.count > savedWeek.days.count{
            for (index,day) in week.days.enumerated() {
                for sDay in savedWeek.days {
                    if day == sDay {
                        week.setDay(at: index, sDay)
                    }
                }
            }
        } else {
            print("Solucionar nueva semana")
        }
    }
    
    /// Add sport to specific day
    func addSport(_ sport: String, to daySport: Date) {
        for day in self.days {
            if day.getDate().comparableDate == daySport.comparableDate {
                day.addSport(sport)
            }
        }
    }
    
    // MARK: - DELETE
    
    func deleteSport(_ sport:String, to daySport: Date) {
        for day in self.days {
            if day.getDate().comparableDate == daySport.comparableDate {
                day.deleteSport(withName: sport)
            }
        }
    }
    
    // MARK: - OTHERS
    
    /// Generate a week form today to monday from the same week
    func generateWeek() {
        let distanceMonday = Date().getDistanceMonday()
        for i in 0..<distanceMonday {
            let day = Day(date: Date() - TimeInterval((84600 * i)))
            self.days.append(day)
        }
    }
    
    /// Generates an id for storing
    func generateID() {
        guard let lastDay = self.days.last else {return}
        self.id = lastDay.getDate().storageDate + "-Monday"
    }
}
