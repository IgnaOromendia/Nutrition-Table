//
//  MenuController.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import UIKit

class AddFoodController: UIViewController {
    
    @IBOutlet weak var view_snack1: UIView!
    @IBOutlet weak var view_Breakfast: UIView!
    @IBOutlet weak var view_lunch: UIView!
    @IBOutlet weak var view_snak2: UIView!
    @IBOutlet weak var view_afternoon: UIView!
    @IBOutlet weak var view_dinner: UIView!
    @IBOutlet weak var view_pop: UIView!
    @IBOutlet var view_effect: UIVisualEffectView!
    
    
    @IBOutlet weak var im_breakfast: UIImageView!
    @IBOutlet weak var im_snack1: UIImageView!
    @IBOutlet weak var im_lunch: UIImageView!
    @IBOutlet weak var im_snak2: UIImageView!
    @IBOutlet weak var im_afternoon: UIImageView!
    @IBOutlet weak var im_dinner: UIImageView!
    
    @IBOutlet weak var btn_backFromPop: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        AddFoodViewModel.setPopOver(btn_backFromPop, view_pop)
        AddFoodViewModel.setViews([view_Breakfast,view_snack1,view_lunch,view_snak2,view_afternoon,view_dinner])
        AddFoodViewModel.setImages([im_breakfast,im_snack1,im_lunch,im_snak2,im_afternoon,im_dinner])
    }
    
    
    
    @IBAction func btn_breakfast(_ sender: Any) {
        Animation.animate(.in_, viewBlur: view_effect, navController: navigationController!)
    }
    
    @IBAction func backFromPop(_ sender: Any) {
        // Modificar las comidas
        Animation.animate(.out_, viewBlur: view_effect, navController: navigationController!)
    }
    
}
