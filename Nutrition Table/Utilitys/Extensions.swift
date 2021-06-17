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
    
    var circle: Bool {
        get {
            if self.layer.cornerRadius > 0 {
                return true
            } else {
                return false
            }
        } set {
            clipsToBounds = newValue
            self.layer.cornerRadius = newValue ? self.frame.size.width / 2 : 0
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

extension UIViewController {
    /// Para modificar el navigation bar desde el codigo y mas rapido
    /// - Parameters:
    ///   - titulo: Titulo del navigation
    ///   - color: Color de las letras
    ///   - largeTitle: Para hacerlo Large  (predeterminado chico)
    func setNavigationBar(titulo:String? = nil, color:UIColor? = nil, largeTitle: Bool = false) {
        navigationItem.title = titulo
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = largeTitle
        if let color = color {
            navigationController?.navigationBar.tintColor = color
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:color]
        }
    }
    
    func setNavigationTransparent(title: String? = nil) {
        navigationItem.title = title
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    /// Para hacer transiciones simples de un ViewController a otro
    func transition(a id:String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destino = storyboard.instantiateViewController(identifier: id)
        navigationController?.pushViewController(destino, animated: true)
    }
}

extension Date {
    /// Devuelve la fecha en formato dd/mm/aa u Hoy o Manana
    /// - Returns: Fecha en string
//    func obtenerComponentesFecha() -> String {
//        let fecha = Calendar.current.dateComponents([.day,.month,.year], from: self)
//        let componenetes = (dia:fecha.day!,mes:fecha.month!,ano:fecha.year!)
//        let fechaActual = Calendar.current.dateComponents([.day,.month,.year], from: Date())
//        let fechaSiguiente = Calendar.current.date(byAdding: Calendar.Component.day, value: 1, to: Date())!
//        let fechaSiguienteComponenetes = Calendar.current.dateComponents([.day,.month,.year], from: fechaSiguiente)
//        if fecha == fechaActual {
//            return "Hoy"
//        } else if fecha == fechaSiguienteComponenetes {
//            return "Mañana"
//        } else {
//            return "\(componenetes.dia)/\(componenetes.mes)/\(componenetes.ano)"
//        }
//    }
    
    func getHour() -> Int {
        let date = Calendar.current.dateComponents([.hour], from: self)
        return date.hour ?? -1
    }
    
}

extension UIColor {
    private static func rgbColor(r:Int, g:Int, b:Int) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
    static var darkRedC:         UIColor {return rgbColor(r: 184, g: 23, b: 18)}
    static var lightRedC:        UIColor {return rgbColor(r: 255, g: 119, b: 111)}
    static var lightPurpleC:     UIColor {return rgbColor(r: 125, g: 86, b: 198) }
    static var darkPurpleC:      UIColor {return rgbColor(r: 63, g: 0, b: 141)}
    static var bluePurpleC:      UIColor {return rgbColor(r: 36, g: 0, b: 217)}
    static var blueGreenC:       UIColor {return rgbColor(r: 0, g: 145, b: 147)}
    static var greenC:           UIColor {return rgbColor(r:79, g:143, b:0)}
    static var lightGreenC:      UIColor {return rgbColor(r: 73, g: 158, b: 78)}
    static var redC:             UIColor {return rgbColor(r:240, g:13, b:0)}
    static var blueC:            UIColor {return rgbColor(r:0, g:122, b:255)}
    static var orangeC:          UIColor {return rgbColor(r:255, g:147, b:0)}
    static var lightOrangeC:     UIColor {return rgbColor(r: 255, g: 178, b: 97)}
    static var lightyellowC:     UIColor {return rgbColor(r: 255, g: 252, b: 121)}
    static var purplceC:         UIColor {return rgbColor(r:102, g:32, b:185)}
}

extension UITextView {
    func makePlaceholder(_ text: String) {
        self.textColor = .darkGray
        self.text = text
    }
    
    func removePlaceholder() {
        self.text = ""
        self.textColor = .black
    }
}
