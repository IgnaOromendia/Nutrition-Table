//
//  HomeViewModel.swift
//  Nutrition Table
//
//  Created by Igna on 22/06/2021.
//

import Foundation
import UIKit

class HomeViewModel {
    
    private static let colorViewToady = UIColor.rgbColor(r: 10, g: 170, b: 205)
    private static let colorViewAddRecommended = UIColor.rgbColor(r: 246, g: 88, b: 38)
    private static let colorViewExport = UIColor.rgbColor(r: 72, g: 188, b: 167)
    private static let colorViewAdd = UIColor.rgbColor(r: 255, g: 197, b: 47)
    private static let colorViewWeek = UIColor.rgbColor(r: 117, g: 175, b: 90)
    private static let colorViewConfig = UIColor.rgbColor(r: 245, g: 245, b: 245)
    private static let colorViewCalendar = UIColor.rgbColor(r: 128, g: 106, b: 192)
    private static let colorViewMeal = UIColor.rgbColor(r: 149, g: 191, b: 255)
    private static let colorAdded = UIColor.rgbColor(r: 123, g: 214, b: 33)
    private static let colorNotAdded = UIColor.rgbColor(r: 234, g: 72, b: 72)
    
    private static let colors = [colorViewToady,colorViewAddRecommended,colorViewExport,
                                 colorViewAdd,colorViewWeek,colorViewConfig,colorViewCalendar]
    
    private static let im_addRecommended = UIImage(named: "addRecommended.png")
    private static let im_add = UIImage(systemName: "plus")
    private static let im_gear = UIImage(systemName: "gear")
    private static let im_calendar = UIImage(systemName: "calendar")
    private static let im_export = UIImage(systemName: "square.and.arrow.up")
    
    private static var texts = ["Name's day","Date","Add recommended",
                                "Export","Add","Week","Calendar"]
    
    private static let images = [im_addRecommended,im_export,im_add,
                                 im_gear,im_calendar]
  
    static func setView(_ views: [UIView]) {
        for (index,view) in views.enumerated() {
            view.cornerRadius(de: 20)
            view.shadow = true
            view.backgroundColor = colors[index]
        }
    }
    
    private static func labelAddName() -> String {
        // Estaria bueno q vaya aprendiendo los horarios del usuario
        switch Date().hour {
            case 0..<5:
                foodDay = .dinner
                return "Add Dinner"
            case 5..<11:
                foodDay = .breakfast
                return "Add Breakfast"
            case 11..<12:
                foodDay = .snack1
                return "Add Snack"
            case 12..<15:
                foodDay = .lunch
                return "Add Lunch"
            case 15..<16:
                foodDay = .snack2
                return "Add Snack"
            case 16..<19:
                foodDay = .afternoonSnack
                return "Add Afternoon Snack"
            case 19..<24:
                foodDay = .dinner
                return "Add Dinner"
            default:
                return ""
        }
    }
    
    private static func setSpecialTexts() {
        texts[0] = Date().getNameDay(day: Date())
        texts[1] = Date().dayMonthDate
        texts[2] = labelAddName()
    }
    
    static func setLabels(_ labels: [UILabel]) {
        setSpecialTexts()
        for (index,label) in labels.enumerated() {
            label.textColor = .white
            label.text = texts[index]
            // aca poner la fuente
            // label.font = label.font.withSize(36)
        }
    }
    
    static func setImages(_ imageViews: [UIImageView]) {
        for (index,imageView) in imageViews.enumerated() {
            imageView.image = images[index]
            if index != images.count - 2 {
                imageView.tintColor = .white
            } else {
                imageView.tintColor = .black
            }
            
        }
    }

    private static func setCircleView(_ circleViews: [String:UIView]) {
        for (key,value) in circleViews {
            value.circle = true
            value.backgroundColor = Week.getDay(from: Date())?.getAllMeals()[key] == nil ? colorNotAdded : colorAdded
        }
    }
    
    static func setTodayViews(_ views: [UIView], _ circleViews: [String:UIView], _ labels: [UILabel]) {
        for (index,view) in views.enumerated() {
            view.cornerRadius(de: 11)
            view.backgroundColor = colorViewMeal
            labels[index].textColor = .white
        }
        setCircleView(circleViews)
    }

    static func reloadTodayView(_ circles: [String:UIView]) {
        let today = Week.getDay(from: Date())?.getAllMeals()
        if let today = today {
            for (key, value) in today {
                if value != nil {
                    if let circle = circles[key] {
                        Animation.animateColorChange(circle, to: colorAdded)
                    }
                } else {
                    if let circle = circles[key] {
                        Animation.animateColorChange(circle, to: colorNotAdded)
                    }
                }
            }
        }
    }
    
    static func setAdjustableFontSize(_ labels: [UILabel]) {
        for label in labels {
            label.adjustsFontSizeToFitWidth = true
        }
    }
    
    
}

