//
//  DayViewModel.swift
//  Nutrition Table
//
//  Created by Matías Della Torre on 19/06/2021.
//

import Foundation
import UIKit


class DayViewModel {
    static func deleteFood(_ date:Date,_ type: DayFoodType?, _ food: Food?) {
        if let type = type {
            if  let food = food {
                for day in week.days {
                    if day.getDate().comparableDate == date.comparableDate {
                        day.getMeal(tipo: type)?.deleteFood(food)
                    }
                }
            } else {
                // Error
            }
        } else {
            // Error
        }
    }
}


