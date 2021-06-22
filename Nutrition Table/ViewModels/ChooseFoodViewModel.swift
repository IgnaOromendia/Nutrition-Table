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
}
