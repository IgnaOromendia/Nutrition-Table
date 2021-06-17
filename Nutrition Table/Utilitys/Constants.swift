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
}

typealias Snaks = (s1:Food, s2: Food)
typealias UITableViewMethos = UITableViewDelegate & UITableViewDataSource

var imagesMenu: [UIImage?] = [UIImage(named: "cafecito.png"),
                          UIImage(named: "chips.png"),
                          UIImage(named: "salad.png"),
                          UIImage(named: "choco.png"),
                          UIImage(named: "croissant.png"),
                          UIImage(named: "meat")]
