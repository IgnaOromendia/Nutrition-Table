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
    var shadow: Bool {
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
    
    // Circle view
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
    
    // Corner Radius
    func cornerRadius(de numero:CGFloat) {
        self.layer.cornerRadius = numero
    }
}

extension UIViewController {
    /// Para modificar el navigation bar desde el codigo y mas rapido
    /// - Parameters:
    ///   - titulo: Titulo del navigation
    ///   - color: Color de las letras
    ///   - largeTitle: Para hacerlo Large  (predeterminado chico)
//    func setNavigationBar(titulo:String? = nil, color:UIColor? = nil, largeTitle: Bool = false) {
//        navigationItem.title = titulo
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.prefersLargeTitles = largeTitle
//        if let color = color {
//            navigationController?.navigationBar.tintColor = color
//            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:color]
//        }
//    }
    
    func setNavigationBar(title: String?, color: UIColor?) {
        navigationItem.title = title
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = color
        
    }
    
    // Set the navigation trnasparent
    func setNavigationTransparent(title: String? = nil) {
        navigationItem.title = title
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // Transifiton from vc to vc
    func transition(to id:String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destino = storyboard.instantiateViewController(identifier: id)
        navigationController?.pushViewController(destino, animated: true)
    }
}

extension Date {
    
    // Get hour
    var hour: Int {
        get {
            let date = Calendar.current.dateComponents([.hour], from: self)
            return date.hour ?? -1
        }
    }
    
    // Get a string date 12/12/2021 with this fomrat
    var comparableDate: String {
        get {
            let date = Calendar.current.dateComponents([.day,.month,.year], from: self)
            return "\(date.day ?? -1)/\(date.month ?? -1)/\(date.year ?? -1)"
        }
    }
    
    // Get string date 26/3
    var dayMonthDate: String {
        get {
            let date = Calendar.current.dateComponents([.day,.month], from: self)
            return "\(date.day ?? -1)/\(date.month ?? -1)"
        }
    }
    
    // Get today comparable day
    static var today: String {
        get {
            return Date().comparableDate
        }
    }
    
    // Get the distance between today and Monday from the current week
    func getDistanceMonday() -> Int {
        let date = Calendar.current.dateComponents([.weekday], from: self)
        let firstweekDay = Calendar.current.firstWeekday
        let distance = abs((date.weekday?.distance(to: firstweekDay) ?? 0)) + 1
        return distance == 0 ? 1 : distance
    }
    
    func getNameDay(day: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from:day)
    }
    
    // Get all the days between today and Monday from the current week
    func getWeekDays() -> [WeekDay] {
        var days: [WeekDay] = []
        let dayDistance = getDistanceMonday()

        for i in 0..<dayDistance {
            let day = self - TimeInterval(86400 * i)
            let weekDay = getNameDay(day: day)
            days.append((day,weekDay))
        }
        
        return days
    }
}

extension UIColor {
    // Set a RGB color
    static func rgbColor(r:Int, g:Int, b:Int) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
    // Colos
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
    static var purpleC:          UIColor {return rgbColor(r:102, g:32, b:185)}
    static var purpleWhiteC:     UIColor {return rgbColor(r:68, g:66, b:153)}
    static var redWhiteC:        UIColor {return rgbColor(r:216, g:75, b:83)}
    
    // choose random color from predefined array
    static func randomColor() -> UIColor? {
        let colors: [UIColor] = [greenC,blueC,orangeC, purpleWhiteC, redWhiteC, lightOrangeC]
        return colors.randomElement()
    }
}

extension UITextView {
    
    //Placeholders
    func makePlaceholder(_ text: String) {
        self.textColor = .darkGray
        self.text = text
    }
    
    func removePlaceholder() {
        self.text = ""
        self.textColor = .black
    }
}


extension Data {
    
    func dataToFile(fileName:String, filePath: String) -> URL? {
        let data = self
        
        do {
            try data.write(to: URL(fileURLWithPath: filePath))
            return URL(fileURLWithPath: filePath)
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
}

extension String {
    
    func background(_ color:UIColor?) -> NSMutableAttributedString {
        if let color = color {
            let attribute = [NSMutableAttributedString.Key.backgroundColor:color]
            return NSMutableAttributedString(string: self, attributes: attribute)
        } else {
            return NSMutableAttributedString(string: self)
        }
        
    }
    
}

extension Array where Element == UIView {
    func withTag(_ index: Int) -> UIView? {
        for view in self {
            if view.tag == index {
                return view
            }
        }
        return nil
    }
}
