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
