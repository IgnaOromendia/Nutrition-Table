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

enum DayFoodType: String {
    case breakfast = "Breakfast"
    case lunch = "Launch"
    case snack1 = "Pre lunch snack"
    case snack2 = "Post lunch snack"
    case afternoonSnack = "Afternoon snack"
    case dinner = "Dinner"
}

enum AddMealWarning: LocalizedError {
    case alreadyContainsMeal
    case todayError
}

enum AddFoodWarning: LocalizedError {
    case foodTextEmpty
    case alreadyContainsFood
}

typealias Snaks = (s1:Meal, s2: Meal)
typealias UITableViewMethdos = UITableViewDelegate & UITableViewDataSource
typealias UICollectionViewMethods = UICollectionViewDelegate & UICollectionViewDataSource
typealias WeekDay = (date: Date, dateDay: String)
typealias TypeAndMeal = (type:DayFoodType, meal: Meal)

var imagesMenu: [UIImage?] = [UIImage(named: "cafecito.png"),
                              UIImage(named: "chips.png"),
                              UIImage(named: "salad.png"),
                              UIImage(named: "choco.png"),
                              UIImage(named: "croissant.png"),
                              UIImage(named: "meat")]

let textViewAddFoodPlaceHolder = "Write down your food here"

// Row Heights
let addFoodCellHeight: CGFloat = 56
let weekCellHeight: CGFloat = 204

// Storyboard id

let addFoodid = "addFoodid"
let chooseid = "chooseid"
let weekid = "weekid"
let calendarid = "calendarid"
let todayid = "todayid"
let configid = "configid"
let exportid = "exportid"

//
