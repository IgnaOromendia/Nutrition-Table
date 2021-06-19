//
//  ChooseFoodViewModel.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation
import UIKit

class ChooseFoodViewModel {
    static func setImages(_ images:[UIImageView]) {
        for i in 0...(images.count - 1) {
            if let image = imagesMenu[i] {
                images[i].image = image
            }
        }
    }
    
    static func setViews(_ views:[UIView]) {
        for view in views {
            view.cornerRadius(de: 15)
            view.shadow = true
        }
    }
    
    // Use in home view
//    static func labelAddName() -> String {
//        // Estaria bueno q vaya aprendiendo los horarios del usuario
//        switch Date().getHour() {
//        case 5..<11:
//            return "Add Breakfast"
//        case 11..<12:
//            return "Add Snack"
//        case 12..<15:
//            return "Add Lunch"
//        case 15..<16:
//            return "Add Snack"
//        case 16..<19:
//            return "Add Afternoon Snack"
//        case 19..<5:
//            return "Add Dinner"
//        default:
//            return ""
//        }
//    }
    
}
