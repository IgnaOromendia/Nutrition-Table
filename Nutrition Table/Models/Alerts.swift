//
//  Alerts.swift
//  Nutrition Table
//
//  Created by Igna on 24/06/2021.
//

import Foundation
import UIKit

class Show {
    static func show(_ controller: UIViewController, in vc: UIViewController) {
        vc.present(controller, animated: true)
    }
}

class Share: Show {
    static func share(_ items: [Any], in vc:UIViewController) {
        let shareScreen = UIActivityViewController(activityItems: items, applicationActivities: nil)
        show(shareScreen, in: vc)
    }
}

class Alert: Show {
    
    private static let defalutAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    private static let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    static func simplePopOver(title: String, message: String, in vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(defalutAction)
        show(alert, in: vc)
    }
    
    static func deletePopOver(title: String, message: String, in vc:UIViewController, handler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(cancelAction)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            handler()
        }))
        show(alert, in: vc)
    }
    
}
