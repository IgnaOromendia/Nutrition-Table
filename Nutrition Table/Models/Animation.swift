//
//  Animation.swift
//  Nutrition Table
//
//  Created by Igna on 16/06/2021.
//

import Foundation
import UIKit

class Animation {
    private static let pantallaCompleta: UIWindow? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    
    enum AnimationType {
        case in_
        case out_
    }
    
    #warning("ver si se puede hacer un general")
    //Animation of alhpa
    static func animateAlpha(_ view:UIView, _ type:Bool) {
        let alpha: CGFloat = type ? 1 : 0
        UIView.animate(withDuration: 0.4) {
            view.alpha = alpha
        }
    }
}
