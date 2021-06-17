//
//  AddFoodController.swift
//  Nutrition Table
//
//  Created by Igna on 16/06/2021.
//

import UIKit

class AddFoodController: UIViewController, UITextViewDelegate, UITableViewMethos {
    
    @IBOutlet weak var food_tableView: UITableView!
    @IBOutlet weak var typeFood_segmentedControl: UISegmentedControl!
    @IBOutlet weak var food_textView: UITextView!
    @IBOutlet weak var btn_addFood: UIButton!
    @IBOutlet weak var lbl_switchFoodType: UILabel!
    @IBOutlet weak var foodType_switch: UISwitch!
    @IBOutlet weak var view_switch: UIView!
    
    var meal = Meal()
    var foodType: FoodType? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddFoodViewModel.setViewSwitch(view_switch,foodType_switch)
        AddFoodViewModel.setDoneButton(btn_addFood)
        AddFoodViewModel.setTextView(food_textView)
        AddFoodViewModel.setSegmentedControl(typeFood_segmentedControl)
    }
    
    @IBAction func switch_foodType(_ sender: UISwitch) {
        if !sender.isOn {
            foodType = nil
        }
        Animation.animateAlphaSegment(typeFood_segmentedControl, sender.isOn)
    }
    
    @IBAction func changeFoodType(_ sender: UISegmentedControl) {
        AddFoodViewModel.setSegmentedControl(sender)
    }
    
    // MARK: - TEXTS
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        textView.textColor = .black
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            do {
                try AddFoodViewModel.addFood(to: &meal, name: textView.text, type: foodType)
            } catch {
                print("La conn")
            }
            
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // MARK: - TABLEVIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meal.foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addFoodCellid",for: indexPath) as! AddFoodCell
        cell.setCell(text: meal.foods[indexPath.row].name, type: meal.foods[indexPath.row].type)
        return cell
    }
    
}
