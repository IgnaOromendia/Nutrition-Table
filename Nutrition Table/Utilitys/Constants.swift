//
//  Constants.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation

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

typealias Snaks = (s1:Food, s2: Food)
