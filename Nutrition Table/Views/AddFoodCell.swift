//
//  AddFoodCell.swift
//  Nutrition Table
//
//  Created by Igna on 16/06/2021.
//

import UIKit

class AddFoodCell: UITableViewCell {

    @IBOutlet weak var view_foodType: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setCell(text:String, type: FoodType?) {
        selectionStyle = .none
        textLabel?.text = text
        view_foodType.circle = true
        switch type {
        case .protein:
            view_foodType.backgroundColor = .orangeC
        case .carbohydrates:
            view_foodType.backgroundColor = .yellow
        case .vegetables:
            view_foodType.backgroundColor = .greenC
        case .none:
            view_foodType.backgroundColor = .white
        }
    }

}
