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
    
    static func animate(_ anim:AnimationType, viewBlur:UIView, navController:UINavigationController) {
        switch anim {
        case .in_:
            pantallaCompleta?.addSubview(viewBlur)
            viewBlur.alpha = 0
            UIView.animate(withDuration: 0.2) {
                viewBlur.alpha = 1
            }
        case .out_:
            navController.navigationBar.layer.zPosition = 0
            UIView.animate(withDuration: 0.2, animations: {
                viewBlur.alpha = 0
            }) { (_) in
                viewBlur.removeFromSuperview()
            }
        }
    }
}
