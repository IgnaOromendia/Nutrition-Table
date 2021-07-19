//
//  StorageManager.swift
//  Nutrition Table
//
//  Created by Igna on 01/07/2021.
//

import Foundation

class StorgareManager {
    
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    
    private func getDocumentDirectory() -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    private func fileURL(fileName: String, in directory: URL) -> URL {
        return directory.appendingPathComponent(fileName)
    }
    
    func saveWeekData(week: Week) {
        let fileName = "\(week.getID()).json"
        do {
            guard let documentDirectory = getDocumentDirectory() else { print("couldn't find directory"); return }
            try FileManager().createDirectory(at: documentDirectory, withIntermediateDirectories: true, attributes: nil)
            let jsonURL = fileURL(fileName: fileName, in: documentDirectory)
            jsonEncoder.outputFormatting = .prettyPrinted
            let jsonData = try jsonEncoder.encode(week)
            try jsonData.write(to: jsonURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readWeekData(id: String) -> Week {
        let fileName = "\(id).json"
        var week = Week()
        do {
            guard let documentDirectory = getDocumentDirectory() else { print("couldn't find directory"); return week }
            let jsonURL = fileURL(fileName: fileName, in: documentDirectory)
            let savedData = try Data(contentsOf: jsonURL)
            week = try jsonDecoder.decode(Week.self, from: savedData)
        } catch {
            print(error.localizedDescription)
        }
        return week
    }
    
    func saveSportsData(_ sports:[String]) {
        do {
            if let filePath = Bundle.main.path(forResource: "sports", ofType: "json") {
                let jsonData = try jsonEncoder.encode(sports)
                try jsonData.write(to: URL(fileURLWithPath: filePath))
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readSportsData() -> [String] {
        var result = [String]()
        do {
            if let filePath = Bundle.main.path(forResource: "sports", ofType: "json") {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath))
                result = try JSONDecoder().decode(Array<String>.self, from: jsonData)
            }
        } catch {
            result = ["Error reading JSON"]
            print(error.localizedDescription)
        }
        return result
    }
    
}
