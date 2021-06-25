//
//  Alerts.swift
//  Nutrition Table
//
//  Created by Igna on 24/06/2021.
//

import Foundation
import UIKit

class Share {
    static func share(_ items: [Any], in vc:UIViewController) {
        let shareScreen = UIActivityViewController(activityItems: items, applicationActivities: nil)
        vc.present(shareScreen, animated: true, completion: nil)
    }
}
