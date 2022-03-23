//
//  DayViewModel.swift
//  Nutrition Table
//
//  Created by Matías Della Torre on 19/06/2021.
//

import Foundation
import UIKit


class DayViewModel {
    
    static func setDeleteAllBtn(_ btn:UIBarButtonItem, _ count:Int) {
        btn.isEnabled = count > 1
    }
    
    static func deleteFood(_ date:Date,_ type: DayFoodType?, _ food: Food?) {
        guard let type = type else { return }
        guard let food = food else { return }
        
        for day in currentWeek.getAllDays() {
            if day.getDate().comparableDate == date.comparableDate {
                day.getMeal(tipo: type)?.deleteFood(food)
                if let meal = day.getMeal(tipo: type) {
                    if meal.getFoodArray().isEmpty {
                        day.deleteMeal(type)
                    }
                }
            }
        }
    }
    
    static func deleteAll(_ date:Date) {
        for day in currentWeek.getAllDays() {
            if day.getDate().comparableDate == date.comparableDate {
                day.deleteAllMeals()
                day.deleteAllSports()
            }
        }
    }
}


