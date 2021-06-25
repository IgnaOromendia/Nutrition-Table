//
//  PDFCreator.swift
//  Nutrition Table
//
//  Created by Igna on 24/06/2021.
//

import Foundation
import UIKit
import PDFKit

class PDFCreator {
    
    func createDocument() -> Data {
        let pdfMetaData = [kCGPDFContextAuthor : "Ignacio Oromendia"]
        
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
            let text = "Test PDF"
            text.draw(at: CGPoint(x: 0, y: 0), withAttributes: [:])
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
    
}
