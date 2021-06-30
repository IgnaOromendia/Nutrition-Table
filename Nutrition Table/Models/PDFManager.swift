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
    
    func createDocument() -> Data {
        let pdfMetaData = [kCGPDFContextAuthor : "Ignacio Oromendia", kCGPDFContextTitle : "Test"]
        
        //let weekData = tableData.getTable()
        let firstColumnTitle  = tableData.getFirstColumnTitle()
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String:Any]
        
        // US letter size
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        // Renders the pdf
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { context in
            context.beginPage()
            let distanceFromOrigin: CGFloat = 10
            let cgContext = context.cgContext
            let rowSize = rowSize(for: 7, in: pageRect, offset: distanceFromOrigin)
            let columnSize = columnSize(for: 7, in: pageRect, offset: distanceFromOrigin)
            
            //let testText = NSMutableAttributedString(string: "test")
            
            let rowCenter = CGPoint(x: pageRect.height - (2 * distanceFromOrigin), y: rowSize / 2)
            
            // Drawing Bounds
            pdfDrawer.drawBorderLines(cgContext, pageRect: pageRect, distanceFromOrigin: distanceFromOrigin)
            pdfDrawer.drawLines(cgContext, pageRect: pageRect, separation: rowSize, numberOfLines: 6, distanceFromOrigin: distanceFromOrigin, .vertical)
            pdfDrawer.drawLines(cgContext, pageRect: pageRect, separation: columnSize, numberOfLines: 6, distanceFromOrigin: distanceFromOrigin, .horizontal)
            
            // Drawing Content
            pdfDrawer.drawFirstColumn(cgContext, pageRect: pageRect, texts: firstColumnTitle, separation: rowSize, at: rowCenter, fontSize: fontSizeTitleColumn)
            
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
        let size = (pageRect.width - (2.0 * offset)) / CGFloat(items)
        return size
    }
    
    /// Column size
    private func columnSize(for items:Int, in pageRect: CGRect, offset: CGFloat) -> CGFloat {
        let size = (pageRect.height - (2 * offset)) / CGFloat(items)
        return size
    }
    
}

// MARK: - PDFDRAWS

class PDFDraws {
    
    enum Orientation {
        case horizontal
        case vertical
    }
    
    func drawLine(_ drawContext: CGContext, pageRect: CGRect, offset: CGFloat, distanceFromOrigin:CGFloat, _ orientation: Orientation) {
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
    
    func drawLines(_ drawContext: CGContext, pageRect: CGRect, separation: CGFloat, numberOfLines:Int, distanceFromOrigin: CGFloat, _ orientation: Orientation) {
        for n in 1..<numberOfLines + 1 {
            drawLine(drawContext, pageRect: pageRect, offset: CGFloat(n) * separation, distanceFromOrigin: distanceFromOrigin, orientation)
        }
    }
    
    func drawCellText(_ drawContext: CGContext, pageRect: CGRect, text: NSAttributedString, at point: CGPoint) {
        drawContext.saveGState()
        drawContext.rotate(by: -90.0 * CGFloat.pi / 180.0)
        text.draw(at: CGPoint(x: -point.x, y: point.y))
        drawContext.restoreGState()
    }
    
    func drawFirstColumn(_ drawContext: CGContext, pageRect: CGRect, texts: [NSMutableAttributedString], separation: CGFloat, at point:CGPoint, fontSize: CGFloat) {
        for (index,text) in texts.enumerated() {
            text.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: fontSize), range: NSMakeRange(0, text.length))
            let py = point.y + (separation * CGFloat(index)) - text.size().height / 2 // Completley centered
            drawCellText(drawContext, pageRect: pageRect, text: text, at: CGPoint(x: point.x, y: py))
        }
    }
    
    func drawBorderLines(_ drawContext: CGContext, pageRect: CGRect, distanceFromOrigin: CGFloat) {
        drawLine(drawContext, pageRect: pageRect, offset: 10, distanceFromOrigin: distanceFromOrigin, .vertical)
        drawLine(drawContext, pageRect: pageRect, offset: pageRect.width - 10, distanceFromOrigin: distanceFromOrigin, .vertical)
        drawLine(drawContext, pageRect: pageRect, offset: 10, distanceFromOrigin: distanceFromOrigin, .horizontal)
        drawLine(drawContext, pageRect: pageRect, offset: pageRect.height - 10, distanceFromOrigin: distanceFromOrigin, .horizontal)
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
    
    
    //#warning("Cmabiar estructura, hacer como si fuese una lista pero de costado")
    func createTable(week: Week) {
        for day in week.days {
            let meals = day.getMealsSorted(complete: true)
            let day = day.getDate().dayMonthDate
            matrix[0].append(NSMutableAttributedString(string: day))
            for i in 0...(meals.meal.count - 1) {
                let meal = meals.meal[i]?.getFoodNames() ?? "N/A"
                matrix[i+1].append(NSMutableAttributedString(string: meal))
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

    func getTableCSV() -> String {
        var text = ""
        for row in matrix {
            for column in row {
                text.append("\(column),")
            }
            text.append("\n")
        }
        return text
    }
    
}
