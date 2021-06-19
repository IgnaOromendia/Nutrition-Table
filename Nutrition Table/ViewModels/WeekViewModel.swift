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
            if (day.getDate().comparableDate == weekDay.comparableDate) {
                return day
            }
        }
        return nil
    }
    
    static func setCustomNavigation(_ nav: UINavigationController?) {
        nav?.navigationBar.shadowImage = UIImage()
        
    }
    
}
