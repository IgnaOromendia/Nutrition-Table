//
//  Alimento.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation
import UIKit
import CoreData

class Food: CustomStringConvertible, Equatable, Comparable, Codable {
    
    private var name: String
    private var type: FoodType?
    
    var description: String {
        return "\(self.name)"
    }
    
    init(name: String, type: FoodType? = nil) {
        self.name = name
        self.type = type
    }
    
    static func == (lhs: Food, rhs: Food) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func < (lhs: Food, rhs: Food) -> Bool {
        return lhs.name < rhs.name
    }
    
    /// Get name
    func getName() -> String {
        return name
    }
    
    /// Get type
    func getType() -> FoodType? {
        return type
    }
    
    /// Get the name with the background color depending on the type
    func getNameWithBackgorund() -> NSAttributedString {
        return name.background(colorDependingType(type))
    }
    
    /// Get the color depending fo the type
    private func colorDependingType(_ type:FoodType?) -> UIColor? {
        switch type {
        case .protein:
            return .orangeC
        case .carbohydrates:
            return .yellow
        case .vegetables:
            return .greenC
        case .none:
            return nil
        }
    }
    
}

