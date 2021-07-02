//
//  PDFManager.swift
//  Nutrition Table
//
//  Created by Igna on 24/06/2021.
//

import Foundation
import UIKit
import PDFKit

// MARK: - PDFCREATOR

class PDFCreator: NSObject {
    private let tableData = Table()
    private let pdfDrawer = PDFDraws()
    
    private let fontSizeTitleColumn: CGFloat = 32
    private let fontSizeContent: CGFloat     = 14
    private let numberOfRow                  = 7
    private let numberOfColumns              = 7
    private let distanceFromOrigin: CGFloat  = 10
    
    func createDocument() -> Data {
        let pdfMetaData = [kCGPDFContextAuthor : "Ignacio Oromendia"]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String:Any]
        
        // Pdf table content
        tableData.createTable(week: week)
        let weekData = tableData.getTable()
        let firstColumnTitle  = tableData.getFirstColumnTitle()
        
        // A4 horizontal size
        let pageWidth = 10.25 * 72.0
        let pageHeight = 7.75 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

        
        // Renders the pdf
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { context in
            context.beginPage()
            let cgContext = context.cgContext
            let rowSize = rowSize(for: numberOfRow, in: pageRect, offset: distanceFromOrigin)
            let columnSize = columnSize(for: numberOfColumns, in: pageRect, offset: distanceFromOrigin)
            let cellSize = CGSize(width: columnSize, height: rowSize)
            
            let firstCellPoint = CGPoint(x: distanceFromOrigin / 4, y: distanceFromOrigin)
            let firstCellRect = CGRect(origin: firstCellPoint, size: cellSize)
            

            let firstContentCellPoint = CGPoint(x: columnSize, y: distanceFromOrigin)
            let firstContentCellRect = CGRect(origin: firstContentCellPoint, size: cellSize )
            
            // Drawing Bounds
            pdfDrawer.drawBorderLines(cgContext, pageRect: pageRect, distanceFromOrigin: distanceFromOrigin)
            pdfDrawer.drawLines(cgContext, pageRect: pageRect, separation: rowSize, numberOfLines: numberOfRow - 1, distanceFromOrigin: distanceFromOrigin, .horizontal)
            pdfDrawer.drawLines(cgContext, pageRect: pageRect, separation: columnSize, numberOfLines: numberOfColumns - 1, distanceFromOrigin: distanceFromOrigin, .vertical)
            
            // Drawing Content
            pdfDrawer.drawFirstColumn(cgContext, pageRect: pageRect, texts: firstColumnTitle, separation: rowSize, at: firstCellRect, fontSize: fontSizeTitleColumn)
            pdfDrawer.drawContnet(cgContext, pageRect: pageRect, texts: weekData, separation: CGPoint(x: columnSize, y: rowSize), beginsIn: firstContentCellRect, fontSize: fontSizeContent)
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
    
    // MARK: - OTHERS
    
    /// Row size
    private func rowSize(for items: Int , in pageRect: CGRect, offset: CGFloat) -> CGFloat {
        return (pageRect.height - (2.0 * offset)) / CGFloat(items)
    }
    
    /// Column size
    private func columnSize(for items:Int, in pageRect: CGRect, offset: CGFloat) -> CGFloat {
        return (pageRect.width - (2 * offset)) / CGFloat(items)
    }
}

// MARK: - PDFDRAWS

class PDFDraws {
    
    enum Orientation {
        case horizontal
        case vertical
    }
    
    private func drawLine(_ drawContext: CGContext, pageRect: CGRect, offset: CGFloat, distanceFromOrigin:CGFloat, _ orientation: Orientation) {
        var point = CGPoint()
        var linePoint = CGPoint()
        
        drawContext.saveGState()
        drawContext.setLineWidth(1)
        
        switch orientation {
        case .horizontal:
            point = CGPoint(x: distanceFromOrigin, y: offset)
            linePoint = CGPoint(x: pageRect.width - distanceFromOrigin , y: offset)
        case .vertical:
            point = CGPoint(x: offset, y: distanceFromOrigin)
            linePoint = CGPoint(x: offset, y: pageRect.height - distanceFromOrigin)
        }
        
        drawContext.move(to: point)
        drawContext.addLine(to: linePoint)
        drawContext.strokePath()
        drawContext.restoreGState()
    }
    
    private func drawCellText(_ drawContext: CGContext, pageRect: CGRect, text: NSMutableAttributedString, at point: CGRect) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        text.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.length))
        text.draw(in: point)
    }
    
    func drawBorderLines(_ drawContext: CGContext, pageRect: CGRect, distanceFromOrigin: CGFloat) {
        let offset = distanceFromOrigin
        drawLine(drawContext, pageRect: pageRect, offset: offset, distanceFromOrigin: distanceFromOrigin, .vertical)
        drawLine(drawContext, pageRect: pageRect, offset: pageRect.width - offset, distanceFromOrigin: distanceFromOrigin, .vertical)
        drawLine(drawContext, pageRect: pageRect, offset: offset, distanceFromOrigin: distanceFromOrigin, .horizontal)
        drawLine(drawContext, pageRect: pageRect, offset: pageRect.height - offset, distanceFromOrigin: distanceFromOrigin, .horizontal)
    }
    
    func drawLines(_ drawContext: CGContext, pageRect: CGRect, separation: CGFloat, numberOfLines:Int, distanceFromOrigin: CGFloat, _ orientation: Orientation) {
        for n in 1..<numberOfLines + 1 {
            drawLine(drawContext, pageRect: pageRect, offset: CGFloat(n) * separation, distanceFromOrigin: distanceFromOrigin, orientation)
        }
    }
    
    func drawFirstColumn(_ drawContext: CGContext, pageRect: CGRect, texts: [NSMutableAttributedString], separation: CGFloat, at point:CGRect, fontSize: CGFloat) {
        for (index,text) in texts.enumerated() {
            text.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: NSMakeRange(0, text.length))
            let py = point.origin.y + (separation * CGFloat(index))
            drawCellText(drawContext, pageRect: pageRect, text: text, at: CGRect(x: point.origin.x, y: py, width: point.width, height: point.height))
        }
    }
    
    func drawContnet(_ drawContext: CGContext, pageRect: CGRect, texts: [[NSMutableAttributedString]], separation: CGPoint, beginsIn point: CGRect, fontSize: CGFloat) {
        for (iR,textR) in texts.enumerated() {
            for (iC,textC) in textR.enumerated() {
                if iC > 0 {
                    textC.addAttributes([.font: UIFont.boldSystemFont(ofSize: fontSize)], range: NSMakeRange(0, textC.length))
                    let px = point.origin.x + (separation.x * CGFloat(iC - 1))
                    let py = point.origin.y + (separation.y * CGFloat(iR))
                    drawCellText(drawContext, pageRect: pageRect, text: textC, at: CGRect(x: px, y: py, width: point.width, height: point.height))
                }
            }
        }
    }
    
}

// MARK: - TABLE

fileprivate class Table {
    
    private var matrix: [[NSMutableAttributedString]]
    private let rowTitle = ["Fecha","D","C","A","C","M","C"]
    
    init() {
        self.matrix = []
        for row in self.rowTitle {
            self.matrix.append([NSMutableAttributedString(string: row)])
        }
    }
    
    func createTable(week: Week) {
        for day in week.days {
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
        return matrix
    }
    
    func getFirstColumnTitle() -> [NSMutableAttributedString] {
        var result = [NSMutableAttributedString]()
        for row in matrix {
            result.append(row[0])
        }
        return result
    }
}
