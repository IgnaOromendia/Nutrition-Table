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
        let tableFormat = Table(week: week)
        
        print(tableFormat.getTable())
        
        return tableFormat.getTable()
    }
}

class Table {
    private var table: String
    private var rows: [String]
    private var columns: [String]
    private var rowContent: [[String]]
    private let rowTitle = ["Fecha","D","C","A","C","M","C"]
    
    init(table: String, rows:[String], columns: [String], week: Week) {
        self.rows = rows
        self.columns = columns
        self.table = table
        self.rowContent = []
        createContent(week: week)
    }
    
    convenience init(week: Week) {
        self.init(table:"", rows:[], columns: [], week: week)
    }
    
    // Set
    
    func addRow(_ text: String) {
        self.rows.append(text + ",")
    }
    
    func insertRow(_ text: String, at index:Int) {
        self.rows.insert(text + ",", at: index)
    }
    
    func addColumn(_ text: String) {
        self.columns.append(text)
    }
    
    func insertColumn(_ text: String, at index:Int) {
        self.columns.insert(text, at: index)
    }
    
    func addToRow(_ text: String, at index:Int) {
        if index < self.rows.count {
            self.rows[index] += "\(text),"
        }
    }
    
    // Get
    
    func getRow(at index:Int) -> String? {
        guard index < rows.count else { return nil }
        return self.rows[index]
    }
    
    func getAllRows() -> [String] {
        return rows
    }
    
    func getColumn(at index:Int) -> String? {
        guard index < columns.count else { return nil }
        return self.columns[index]
    }
    
    func getAllColumns() -> [String] {
        return columns
    }
    
    func getTable() -> String {
        createTable()
        return table
    }
    
    // Create
    
    private func createTable() {
        for row in self.rowTitle {
            addRow(row)
        }
        
        for column in self.columns {
            addToRow(column, at: 0)
        }
        
        var rowsText: String {
            var text = ""
            for row in self.rows {
                text += "\(row) \n"
            }
            return text
        }
        
        self.table += rowsText
    }
    
    private func createContent(week:Week) {
        let day = week.days.first
        if let day = day {
            self.addColumn(day.getDate().dayMonthDate)
            let meals = day.getAllMeals()
            if let meals = meals {
                var mealsArray: [String] = []
                for meal in meals {
                    mealsArray.append(meal.meal.getFoodNames())
                }
                self.rowContent.append(mealsArray)
                // Falta los q no existen, poner N/A
            }
        }
        //for day in week.days {
            
        //}
    }
    
    
}
