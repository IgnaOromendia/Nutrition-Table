//
//  SportsViewModel.swift
//  Nutrition Table
//
//  Created by Igna on 03/07/2021.
//

import Foundation
import UIKit

class SportsViewModel {
    
    private static let stManager = StorgareManager()
    
    static func filterContentForSearchText(_ text:String, sports:[String], sportsAdded:[String]) -> [String] {
        return sports.filter({ return $0.lowercased().contains(text.lowercased()) && !sportsAdded.contains($0) })
    }
    
    static func addToDaySports(_ sport:String, to date:Date) {
        week.addSport(sport, to: date)
        stManager.saveWeekData(week: week)
    }
    
    static func removeSportFromDay(_ sport: String, to date:Date) {
        week.deleteSport(sport, to: date)
        stManager.saveWeekData(week: week)
    }
    
}
