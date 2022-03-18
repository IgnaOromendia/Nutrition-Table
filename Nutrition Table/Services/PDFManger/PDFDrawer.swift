//
//  PDFDrawer.swift
//  Nutrition Table
//
//  Created by Igna on 20/07/2021.
//

import Foundation
import UIKit
import PDFKit

class PDFDrawer {
    
    private let lineWidth: CGFloat = 1
    private typealias LinePoints = (a:Int, b: Int)
    
    enum Orientation {
        case horizontal
        case vertical
    }
    
    /// Draw a line from A to B (point-to-point)
    func drawLine(in drawContext: CGContext, _ pageRect: CGRect, from a: CGFloat, to b: CGFloat, offset: CGFloat = 0, _ orientation: Orientation) {
        var beginPoint = CGPoint()
        var endPoint = CGPoint()
        
        drawContext.saveGState()
        drawContext.setLineWidth(lineWidth)
        
        switch orientation {
        case .horizontal:
            beginPoint = CGPoint(x: a, y: offset)
            endPoint = CGPoint(x: b, y: offset)
        case .vertical:
            beginPoint = CGPoint(x: offset, y: a)
            endPoint = CGPoint(x: offset, y: b)
        }
        
        drawContext.move(to: beginPoint)
        drawContext.addLine(to: endPoint)
        drawContext.strokePath()
        drawContext.restoreGState()
    }
    
    /// Draw Border rectangle
    func drawBorderLines(in drawContext: CGContext, _ pageRect: CGRect, distanceFromOrigin: CGFloat) {
        let rightUpCorner = CGPoint(x: distanceFromOrigin, y: distanceFromOrigin)
        let leftUpCorner = CGPoint(x: pageRect.width - distanceFromOrigin, y: distanceFromOrigin)
        let rightDownCorner = CGPoint(x: distanceFromOrigin, y: pageRect.height - distanceFromOrigin)
        let leftDownCorner = CGPoint(x: pageRect.width - distanceFromOrigin, y: pageRect.height - distanceFromOrigin)
        
        drawLine(in: drawContext, pageRect, from: rightUpCorner.x, to: leftUpCorner.x, offset: distanceFromOrigin, .horizontal)
        drawLine(in: drawContext, pageRect, from: rightUpCorner.x, to: rightDownCorner.y, offset: distanceFromOrigin, .vertical)
        drawLine(in: drawContext, pageRect, from: rightDownCorner.x, to: leftDownCorner.x, offset: pageRect.height - distanceFromOrigin, .horizontal)
        drawLine(in: drawContext, pageRect, from: leftDownCorner.x, to: leftUpCorner.y, offset: pageRect.width - distanceFromOrigin, .vertical)
    }
    
    /// Draw mulitple point-to-point lines
    func drawLines(in drawContext: CGContext, _ pageRect: CGRect, separation: CGFloat, numberOfLines: Int, from begining: CGFloat, distanceFromOrigin: CGFloat, orientation: Orientation) {
        let endPoint = (orientation == .horizontal) ? pageRect.width - distanceFromOrigin : pageRect.height - distanceFromOrigin
        for n in 1...numberOfLines {
            drawLine(in: drawContext, pageRect, from: distanceFromOrigin, to: endPoint, offset: begining + (separation * CGFloat(n)), orientation)
        }
    }
    
    /// Draw text
    private func drawCellText(in drawContext: CGContext, _ pageRect: CGRect, text: NSMutableAttributedString, at rect: CGRect) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        text.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.length))
        text.draw(in: rect)
    }
    
    /// Draw row titles
    func drawTitleRowCellText(in drawContext: CGContext, _ pageRect: CGRect, texts: [NSMutableAttributedString], separation: CGFloat, beginsIn: CGRect, fontSize: CGFloat) {
        var rect = beginsIn
        for text in texts {
            text.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: NSMakeRange(0, text.length))
            drawCellText(in: drawContext, pageRect, text: text, at: rect)
            rect.origin.x += separation //* CGFloat(index)
        }
    }
    
    /// Draw column titles
    func drawTitleColumnCellText(in drawContext: CGContext, _ pageRect: CGRect, texts: [NSMutableAttributedString], separation: CGFloat, beginsIn: CGRect, fontSize:CGFloat) {
        var rect = beginsIn
        for text in texts {
            text.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: NSMakeRange(0, text.length))
            drawCellText(in: drawContext, pageRect, text: text, at: rect)
            rect.origin.y += separation
        }
    }
    
    /// Draw content in a matrix
    func drawContentCellText(in drawContext: CGContext, _ pageRect: CGRect, textsArray: [[NSMutableAttributedString]], separationY: CGFloat, separationX: CGFloat, beginsIn: CGRect, fontSize: CGFloat) {
        var rect = beginsIn
        for array in textsArray {
            for text in array {
                text.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: NSMakeRange(0, text.length))
                drawCellText(in: drawContext, pageRect, text: text, at: rect)
                rect.origin.x += separationX
            }
            rect.origin.x = beginsIn.origin.x
            rect.origin.y += separationY
        }
    }

}
