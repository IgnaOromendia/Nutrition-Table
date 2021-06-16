//
//  MenuViewModel.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation
import UIKit

class AddFoodViewModel {
    static func setImages(_ images:[UIImageView]) {
        for i in 0...(images.count - 1) {
            if let image = imagesMenu[i] {
                images[i].image = image
            }
        }
    }
    
    static func setViews(_ views:[UIView]) {
        for view in views {
            view.setMenuView()
        }
    }
    
    static func setAddButton(_ view:UIView, _ im_add:UIImageView) {
        view.redondeado(de: 19)
        view.sombra = true
        im_add.image = UIImage(named: "btn_add.png")
    }
    
    static func setPopOver(_ btn:UIButton,_ view: UIView) {
        btn.redondeado(de: 15)
        view.redondeado(de: 25)
    }
    
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
