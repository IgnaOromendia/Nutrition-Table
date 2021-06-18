//
//  WeekViewModel.swift
//  Nutrition Table
//
//  Created by Igna on 17/06/2021.
//

import Foundation
import UIKit


class WeekViewModel {
    
    static func setDay(from weekDay:Date) -> Day? {
        for day in week.days {
            if (day.date.comparableDate == weekDay.comparableDate) {
                return day
            }
        }
        return nil
    }
    
    
}
