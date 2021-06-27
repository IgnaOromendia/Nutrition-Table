//
//  CSVManager.swift
//  Nutrition Table
//
//  Created by Igna on 24/06/2021.
//

import Foundation
import UIKit

class CSVManager {
    
    private func getDocumentDirectory() -> NSString {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = path[0]
        return documentDirectory as NSString
    }
    
    func createFileAndShare(fileName: String, week: Week, _ vc: UIViewController) {
        let path = getDocumentDirectory().appendingPathComponent("\(fileName).csv")
        let table = tableFormat(week: week)
        let fileURL = table.data(using: .utf8)?.dataToFile(fileName: fileName, filePath: path)
        if let fileURL = fileURL {
            Share.share([fileURL], in: vc)
        }
    }
    
    private func tableFormat(week: Week) -> String {
        let tableFormat = Table()
        tableFormat.createTable(week: week)
        return tableFormat.getTableCSV()
    }
}

class Table {
    
    private var matrix: [[String]]
    private let rowTitle = ["Fecha","D","C","A","C","M","C"]
    
    init() {
        self.matrix = []
        for row in self.rowTitle {
            self.matrix.append([row])
        }
    }
    
    func createTable(week: Week) {
        for day in week.days {
            let meals = day.getMealsSorted(complete: true)
            matrix[0].append(day.getDate().dayMonthDate)
            for i in 0...(meals.meal.count - 1) {
                matrix[i+1].append(meals.meal[i]?.getFoodNames() ?? "N/A")
            }
        }
    }
    
    func getTableCSV() -> String {
        var text = ""
        for row in matrix {
            for column in row {
                text.append(column + ",")
            }
            text.append("\n")
        }
        return text
    }
    
}
