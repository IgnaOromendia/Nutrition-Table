//
//  Constants.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation
import UIKit

enum FoodType {
    case protein
    case carbohydrates
    case vegetables
}

enum TipoFoodDelDia {
    case breakfast
    case lunch
    case snak1
    case snak2
    case afternoonSnak
    case dinner
}

enum AddFoodWarningType: Error {
    case foodTextEmpty
    case alreadyContainsFood
}

typealias Snaks = (s1:Meal, s2: Meal)
typealias UITableViewMethos = UITableViewDelegate & UITableViewDataSource
typealias WeekDay = (date: Date, dateDay: String)

var imagesMenu: [UIImage?] = [UIImage(named: "cafecito.png"),
                          UIImage(named: "chips.png"),
                          UIImage(named: "salad.png"),
                          UIImage(named: "choco.png"),
                          UIImage(named: "croissant.png"),
                          UIImage(named: "meat")]
