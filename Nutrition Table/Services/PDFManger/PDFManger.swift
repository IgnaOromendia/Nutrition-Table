//
//  PDFManger.swift
//  Nutrition Table
//
//  Created by Igna on 20/07/2021.
//

import Foundation
import UIKit
import PDFKit

class PDFCreator: NSObject {
    private let tableData = Table(week: week)
    private let pdfDrawer = PDFDrawer()
    
    // Page Size (A4 Horizontal)
    private let pageWidth = 10.25 * 72.0
    private let pageHeight = 7.75 * 72.0
    
    // Fonts
    private let fontSizeTitleColumn: CGFloat = 25
    private let fontSizeTitleRow: CGFloat    = 15
    private let fontSizeContent: CGFloat     = 10
    
    // Items
    private let numberOfRows    = 6
    private let numberOfColumns = 8
    
    // Custom
    private let distanceFromOrigin: CGFloat = 10
    private let titleRowSize: CGFloat       = 50
    
    // Functions
    
    /// Create the pdf document
    func createDocument() -> Data {
        // Format
        
        let pdfMetaData = [kCGPDFContextAuthor : "Ignacio Oromendia"]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String:Any]
        
        // PDF table content
        let weekData = tableData.getTable()
        let columnTitles  = tableData.getFirstColumnTitle()
        let rowTitles = tableData.getFirstRow()
                
        // Render
        
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { context in
            let cgContext = context.cgContext
            context.beginPage()
            
            // Sizes
            
            let rowSize = rowSize(for: numberOfRows, in: pageRect, offset: distanceFromOrigin, from: titleRowSize)
            let columnSize = columnSize(for: numberOfColumns, in: pageRect, offset: distanceFromOrigin)
            
            let titleCellSize = CGSize(width: columnSize, height: titleRowSize)
            let contentCellSize = CGSize(width: columnSize - 6, height: rowSize)
            
            // Origin Points
            
            let firstTitleRowOrigin = CGPoint(x: distanceFromOrigin + columnSize, y: distanceFromOrigin + titleRowSize / 4)
            
            let firstTitleColumnOrigin = CGPoint(x: distanceFromOrigin, y: distanceFromOrigin)
            
            let firstContentCellOrigin = CGPoint(x: distanceFromOrigin + columnSize, y: distanceFromOrigin + rowSize)
            
            // Rects
            
            let firstTitleRowRect = CGRect(origin: firstTitleRowOrigin, size: titleCellSize)
            
            let firstTitleColumnRect = CGRect(origin: firstTitleColumnOrigin, size: titleCellSize)
            
            let firstContentCellRect = CGRect(origin: firstContentCellOrigin, size: contentCellSize)
            
            // Drawing Bounds
            
            pdfDrawer.drawBorderLines(in: cgContext, pageRect, distanceFromOrigin: distanceFromOrigin)
            pdfDrawer.drawLine(in: cgContext, pageRect, from: distanceFromOrigin, to: pageRect.width - distanceFromOrigin, offset: distanceFromOrigin + titleRowSize, .horizontal)
            pdfDrawer.drawLines(in: cgContext, pageRect, separation: rowSize, numberOfLines: numberOfRows - 1, from: distanceFromOrigin + titleRowSize, distanceFromOrigin: distanceFromOrigin, orientation: .horizontal)
            pdfDrawer.drawLines(in: cgContext, pageRect, separation: columnSize, numberOfLines: numberOfColumns - 1, from: distanceFromOrigin, distanceFromOrigin: distanceFromOrigin, orientation: .vertical)
            
            // Drawing Titles
            
            pdfDrawer.drawTitleRowCellText(in: cgContext, pageRect, texts: rowTitles, separation: columnSize, beginsIn: firstTitleRowRect, fontSize: fontSizeTitleRow)
            pdfDrawer.drawTitleColumnCellText(in: cgContext, pageRect, texts: columnTitles, separation: rowSize, beginsIn: firstTitleColumnRect, fontSize: fontSizeTitleColumn)
            
            // Drawing Content
            pdfDrawer.drawContentCellText(in: cgContext, pageRect, textsArray: weekData, separationY: rowSize, separationX: columnSize, beginsIn: firstContentCellRect, fontSize: fontSizeContent)
            
            
        }
        
        return data
    }
    
    func showDocument(_ documentData: Data?, in view:PDFView) {
        if let documentData = documentData {
            view.document = PDFDocument(data: documentData)
            view.autoScales = true
        }
    }
    
    func createAndShowDocument(in view:PDFView) {
        let data = createDocument()
        showDocument(data, in: view)
    }
    
    func shareDocument(_ documentData: Data?, in vc: UIViewController) {
        if let documentData = documentData {
            Share.share([documentData], in: vc)
        }
    }
    
    // Others
    
    /// Row size
    private func rowSize(for items: Int, in pageRect: CGRect, offset: CGFloat, from begins: CGFloat) -> CGFloat {
        return (pageRect.height - (2.0 * offset) - begins) / CGFloat(items)
    }
    
    /// Column size
    private func columnSize(for items:Int, in pageRect: CGRect, offset: CGFloat) -> CGFloat {
        return (pageRect.width - (2 * offset)) / CGFloat(items)
    }
    
    
}

// MARK: - TABLE

fileprivate class Table {
    
    private var matrix: [[NSMutableAttributedString]]
    private let rowTitle = ["Fecha","D","C","A","C","M","C"]
    
    init(week: Week) {
        self.matrix = []
        for row in self.rowTitle {
            self.matrix.append([NSMutableAttributedString(string: row)])
        }
        self.createTable(week: week)
    }
    
    private func createTable(week: Week) {
        for day in week.getAllDays() {
            let meals = day.getMealsSorted(complete: true)
            let day = day.getDate().dayMonthDate
            matrix[0].append(NSMutableAttributedString(string: day))
            for i in 0...(meals.meal.count - 1) {
                let meal = meals.meal[i]?.getFoodNamesWithBackground() ?? NSMutableAttributedString(string: "N/A")
                matrix[i+1].append(meal)
            }
        }
    }
    
    func getTable() -> [[NSMutableAttributedString]] {
        var result: [[NSMutableAttributedString]] = []
        for i in 1...(matrix.count-1) {
            var row: [NSMutableAttributedString] = []
            for j in 1...(matrix[i].count-1)  {
                row.append(matrix[i][j])
            }
            result.append(row)
        }
        return result
    }
    
    func getFirstRow() -> [NSMutableAttributedString] {
        var result = [NSMutableAttributedString]()
        for text in matrix[0] {
            result.append(text)
        }
        result.removeFirst()
        return result
    }
    
    func getFirstColumnTitle() -> [NSMutableAttributedString] {
        var result = [NSMutableAttributedString]()
        for row in matrix {
            result.append(row[0])
        }
        return result
    }
}
