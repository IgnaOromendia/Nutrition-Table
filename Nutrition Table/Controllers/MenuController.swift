//
//  MenuController.swift
//  Nutrition Table
//
//  Created by Igna on 15/06/2021.
//

import UIKit

class MenuController: UIViewController {
    
    @IBOutlet weak var view_snack1: UIView!
    @IBOutlet weak var view_Breakfast: UIView!
    @IBOutlet weak var view_lunch: UIView!
    @IBOutlet weak var view_snak2: UIView!
    @IBOutlet weak var view_afternoon: UIView!
    @IBOutlet weak var view_dinner: UIView!
    @IBOutlet weak var view_addFood: UIView!
    
    
    @IBOutlet weak var im_breakfast: UIImageView!
    @IBOutlet weak var im_snack1: UIImageView!
    @IBOutlet weak var im_lunch: UIImageView!
    @IBOutlet weak var im_snak2: UIImageView!
    @IBOutlet weak var im_afternoon: UIImageView!
    @IBOutlet weak var im_dinner: UIImageView!
    @IBOutlet weak var im_addFood: UIImageView!
    
    
    @IBOutlet weak var lbl_addFood: UILabel!
    
    @IBOutlet weak var btn_add: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        MenuViewModel.setViews([view_Breakfast,view_snack1,view_lunch,view_snak2,view_afternoon,view_dinner])
        MenuViewModel.setImages([im_breakfast,im_snack1,im_lunch,im_snak2,im_afternoon,im_dinner])
        MenuViewModel.setAddButton(view_addFood, im_addFood)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbl_addFood.text = MenuViewModel.labelAddName()
    }
    
    
    @IBAction func btn_breakfast(_ sender: Any) {
        // Ir a agregar dasayuno
    }
    
    @IBAction func add_TimeFood(_ sender: Any) {
        // Ir a agregar (Depdne la hora)
    }
    
}
