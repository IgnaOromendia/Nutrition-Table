//
//  Constants.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation
import UIKit

enum FoodType: Int, Codable {
    case protein = 1
    case carbohydrates = 2
    case vegetables = 3
}

enum DayFoodType: String {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case snack1 = "Snack1"
    case snack2 = "Snack2"
    case afternoonSnack = "Afternoon snack"
    case dinner = "Dinner"
}

enum AddMealWarning: LocalizedError {
    case alreadyContainsMeal
    case dayError
    case indexError
    case foodArrayEmpty
}

enum AddFoodWarning: LocalizedError {
    case foodTextEmpty
    case alreadyContainsFood
}

typealias UITableViewMethdos = UITableViewDelegate & UITableViewDataSource
typealias UICollectionViewMethods = UICollectionViewDelegate & UICollectionViewDataSource
typealias WeekDay = (date: Date, dateDay: String)

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
let dayId = "dayid"
let configid = "configid"
let exportid = "exportid"

// Alerts titles

let alreadyContainsTitle = "Already added"
let noFoodAddedTitle = "No food added"
let unknownErrorTitle = "Unknown error"
let textFieldEmptyTitle = "Text field empty"
let deleteFoodTitle = "Deleting "

// Alerts messages

let alreadyContainsMessage = "An item that has been added, can't be added again"
let noFoodAddedMessage = "Can't add an empty meal"
let unknownErrorMessage = "Please report in feedback"
let textFieldEmptyMessage = "Cant't add an empty food"
let deleteFoodMessage = "Are you sure you want to delete "

