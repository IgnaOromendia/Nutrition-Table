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
    
    static func animateAlphaSegment(_ segement:UISegmentedControl, _ type:Bool) {
        let alpha: CGFloat = type ? 1 : 0
        UIView.animate(withDuration: 0.4) {
            segement.alpha = alpha
        }
        
    }
}
