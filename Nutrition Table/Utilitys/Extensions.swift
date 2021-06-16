//
//  Extensions.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation
import UIKit

extension UIView {
    /// Ejemplo: miView.sombra = true
    var sombra: Bool {
        get {
            if self.layer.shadowRadius > 0 {
                return true
            } else {
                return false
            }
        } set {
            if newValue {
                self.layer.shadowOpacity = 0.2
                self.layer.shadowOffset = .init(width: 1, height: 1)
                self.layer.shadowRadius = 3
                self.layer.shadowColor = UIColor.label.cgColor
            } else {
                self.layer.shadowOpacity = 0
                self.layer.shadowOffset = .init(width: 0, height: 0)
                self.layer.shadowRadius = 0
            }
        }
    }
    
    func redondeado(de numero:CGFloat) {
        self.layer.cornerRadius = numero
    }
    
    
    func setMenuView() {
        self.redondeado(de: 15)
        self.sombra = true
    }
    
    
}
