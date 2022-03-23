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
    
    func saveData(data: DataManager) {
        let fileName = "NutritionTableData.json"
        do {
            guard let documentDirectory = getDocumentDirectory() else { print("couldn't find directory"); return }
            try FileManager().createDirectory(at: documentDirectory, withIntermediateDirectories: true, attributes: nil)
            let jsonURL = fileURL(fileName: fileName, in: documentDirectory)
            jsonEncoder.outputFormatting = .prettyPrinted
            let jsonData = try jsonEncoder.encode(data)
            try jsonData.write(to: jsonURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readData() -> DataManager {
        let fileName = "NutritionTableData.json"
        var data = DataManager()
        do {
            guard let documentDirectory = getDocumentDirectory() else { print("couldn't find directory"); return data }
            let jsonURL = fileURL(fileName: fileName, in: documentDirectory)
            let savedData = try Data(contentsOf: jsonURL)
            data = try jsonDecoder.decode(DataManager.self, from: savedData)
        } catch {
            print(error.localizedDescription)
        }
        return data
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
