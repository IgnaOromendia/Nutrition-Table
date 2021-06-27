//
//  ExportController.swift
//  Nutrition Table
//
//  Created by Igna on 24/06/2021.
//

import UIKit
import PDFKit

class ExportController: UIViewController {
    
    @IBOutlet weak var pdfView: PDFView!
    
    let csvManager = CSVManager()
    //let pdfCreator = PDFCreator()
    //var pdfData: Data?

    override func viewDidLoad() {
        super.viewDidLoad()
        pdfView.isHidden = true
        //pdfData = pdfCreator.createDocument()
        //pdfCreator.showDocument(pdfData, in: pdfView)
    }

    @IBAction func share(_ sender: Any) {
        csvManager.createFileAndShare(fileName: "Test", week: week , self)
        //pdfCreator.shareDocument(pdfData, in: self)
    }
    
}
