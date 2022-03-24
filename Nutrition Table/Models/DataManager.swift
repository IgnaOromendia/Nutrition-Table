//
//  DataManager.swift
//  Nutrition Table
//
//  Created by Igna on 23/03/2022.
//

import Foundation

class DataManager: Codable {
    
    private var weeks: [String:Week] // key = week's first date
    private var foodData: [DayFoodType:[String:Int]]
    
    var currentWeek: Week {
        get {
            return DataManager.getWeek(date: Date().storageDate)
        }
    }
    
    init() {
        self.weeks = [:]
        self.foodData = [:]
    }
    
    // MARK: - GET
    
    /// Get a specific week
    static func getWeek(date:String) -> Week {
        let errorWeek = Week()
        errorWeek.generateWeek()
        return nutritionData.weeks[date] ?? errorWeek
    }
    
    /// Get all the food data
    func getFoodData() -> [DayFoodType:[String:Int]] {
        return foodData
        
    }
    
    /// Top 3 most eaten foods at certain moment
    func topMostEaten(at moment:DayFoodType) -> [Food] {
        let foods = self.foodData[moment]
        
        if let foods = foods {
            var maxs: [(name:String,amount: Int)] = [("",0),("",0),("",0)]
            for food in foods {
                if food.value > maxs[0].amount {
                    maxs[2] = maxs[1]
                    maxs[1] = maxs[0]
                    maxs[0] = (food.key,food.value)
                } else if food.value > maxs[1].amount {
                    maxs[2] = maxs[1]
                    maxs[1] = (food.key,food.value)
                } else if food.value > maxs[2].amount {
                    maxs[2] = (food.key,food.value)
                }
            }
            
            return cleanArr(maxs)
        }
        
        return []
    }
    
    
    private func cleanArr(_ arr: [(name:String,amount: Int)]) -> [Food] {
        var result: [Food] = []
        for item in arr {
            if !item.name.isEmpty {
                result.append(Food(name: item.name))
            }
        }
        return result
    }
    
    // MARK: - SET
    
    /// Set the food data
    func setFoodData(data: [DayFoodType:[String:Int]]) {
        self.foodData = data
    }
    
    /// update a week with new data
    func updateWeek(week: Week) {
        self.weeks[week.getMondaysDate().storageDate] = week
    }
    
    /// update the food data
    func updateFoodData(with foods: [Food],at moment: DayFoodType) {
        for food in foods {
            var foodDataMomentDic: [String:Int] = self.foodData[moment] ?? [:]
            let previousValue = foodDataMomentDic[food.getName()] ?? 0
            foodDataMomentDic.updateValue(previousValue + 1, forKey: food.getName())
            self.foodData[moment] = foodDataMomentDic
        }
    }
    
}

