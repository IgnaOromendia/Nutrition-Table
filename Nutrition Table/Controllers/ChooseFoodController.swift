//
//  MenuController.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import UIKit

class ChooseFoodController: UIViewController {
    
    @IBOutlet weak var view_snack1: UIView!
    @IBOutlet weak var view_Breakfast: UIView!
    @IBOutlet weak var view_lunch: UIView!
    @IBOutlet weak var view_snak2: UIView!
    @IBOutlet weak var view_afternoon: UIView!
    @IBOutlet weak var view_dinner: UIView!
    
    @IBOutlet weak var im_breakfast: UIImageView!
    @IBOutlet weak var im_snack1: UIImageView!
    @IBOutlet weak var im_lunch: UIImageView!
    @IBOutlet weak var im_snak2: UIImageView!
    @IBOutlet weak var im_afternoon: UIImageView!
    @IBOutlet weak var im_dinner: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTransparent()
        view.backgroundColor = .orangeC
        ChooseFoodViewModel.setViews([view_Breakfast,view_snack1,view_lunch,view_snak2,view_afternoon,view_dinner])
        ChooseFoodViewModel.setImages([im_breakfast,im_snack1,im_lunch,im_snak2,im_afternoon,im_dinner])
    }
    
    // MARK: - BUTTONS
    
    @IBAction func btn_breakfast(_ sender: Any) {
        foodDay = .breakfast
        self.transition(to: "addFood")
    }
    @IBAction func btn_lunch(_ sender: Any) {
        foodDay = .lunch
        self.transition(to: "addFood")
    }
    @IBAction func btn_snack1(_ sender: Any) {
        foodDay = .snack1
        self.transition(to: "addFood")
    }
    @IBAction func btn_snack2(_ sender: Any) {
        foodDay = .snack2
        self.transition(to: "addFood")
    }
    @IBAction func btn_afternoon(_ sender: Any) {
        foodDay = .afternoonSnack
        self.transition(to: "addFood")
    }
    @IBAction func btn_dinner(_ sender: Any) {
        foodDay = .dinner
        self.transition(to: "addFood")
    }

}
