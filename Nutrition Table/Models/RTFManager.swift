//
//  CSVManager.swift
//  Nutrition Table
//
//  Created by Igna on 24/06/2021.
//

import Foundation
import UIKit

class RTFManager {
    
    private func getDocumentDirectory() -> NSString {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = path[0]
        return documentDirectory as NSString
    }
    
    func createFileAndShare(fileName: String, week: Week, _ vc: UIViewController) {
        let path = getDocumentDirectory().appendingPathComponent("\(fileName).rtf")
    
        let text = "Test"
        let attributedText = text.background(.orangeC)
        do {
            let range = NSMakeRange(0, attributedText.length)
            let fileURL = try attributedText.data(from: range, documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf]).dataToFile(fileName: fileName, filePath: path)
            if let fileURL = fileURL {
                Share.share([fileURL], in: vc)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
