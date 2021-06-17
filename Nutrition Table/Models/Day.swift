//
//  Dia.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import Foundation

class Day {
    var date: Date
    var breakfast: Meal?
    var snaks: Snaks?
    var lunch: Meal?
    var dinner: Meal?
    var afternoonSnak: Meal?
    
    init(breakfast:Meal?, snaks:Snaks?,lunch:Meal?,dinner:Meal?, afternoonSnak:Meal?, date:Date) {
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
        self.afternoonSnak = afternoonSnak
        self.snaks = snaks
        self.date = date
    }
    
    convenience init() {
        self.init(breakfast:nil, snaks:nil,lunch:nil,dinner:nil, afternoonSnak:nil, date: Date())
    }
    
    func getFood(tipo: TipoFoodDelDia) -> Meal? {
        switch tipo {
        case .breakfast:
            guard let breakfast = self.breakfast else {return nil}
            return breakfast
        case .lunch:
            guard let lunch = self.lunch else {return nil}
            return lunch
        case .snak1:
            guard let snak1 = self.snaks?.s1 else {return nil}
            return snak1
        case .snak2:
            guard let snak1 = self.snaks?.s2 else {return nil}
            return snak1
        case .afternoonSnak:
            guard let afternoonSnak = self.afternoonSnak else {return nil}
            return afternoonSnak
        case .dinner:
            guard let dinner = self.dinner else {return nil}
            return dinner
        }
    }
    
    
    func getAllFoods() -> [TipoFoodDelDia:Meal]? {
        var Foods:[TipoFoodDelDia:Meal] = [:]
        
        if let breakfast = self.breakfast {
            Foods[TipoFoodDelDia.breakfast] = breakfast
        }
        
        if let lunch = self.lunch {
            Foods[TipoFoodDelDia.lunch] = lunch
        }
        
        if let dinner = self.dinner {
            Foods[TipoFoodDelDia.dinner] = dinner
        }
        
        if let afternoonSnak = self.afternoonSnak {
            Foods[TipoFoodDelDia.afternoonSnak] = afternoonSnak
        }
        
        // Faltan los snaks
        
        return Foods.count > 0 ? Foods : nil
    }
    
    
    
    
}
