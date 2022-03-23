//
//  DataManager.swift
//  Nutrition Table
//
//  Created by Igna on 23/03/2022.
//

import Foundation

class DataManager: Codable {
    
    private var weeks: [String:Week] // key = week's first date
    
    var currentWeek: Week {
        get {
            return DataManager.getWeek(date: Date().storageDate)
        }
    }
    
    init() {
        self.weeks = [:]
    }
    
    // MARK: - GET
    
    static func getWeek(date:String) -> Week {
        let errorWeek = Week()
        errorWeek.generateWeek()
        return nutritionData.weeks[date] ?? errorWeek
    }
    
    // MARK: - SET
    
    func updateWeek(week: Week) {
        self.weeks[week.getMondaysDate().storageDate] = week
    }
    
}

