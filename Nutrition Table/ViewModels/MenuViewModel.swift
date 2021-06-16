//
//  MenuViewModel.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation
import UIKit

class MenuViewModel {
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
    
    static func setAddButton(_ view:UIView, _ btn:UIButton) {
        view.redondeado(de: 19)
        view.sombra = true
        btn.setBackgroundImage(UIImage(named: "btn_add.png"), for: .normal)
    }
    
}
