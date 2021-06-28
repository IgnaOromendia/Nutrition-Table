//
//  AddFoodController.swift
//  Nutrition Table
//
//  Created by Igna on 16/06/2021.
//

import UIKit

class AddFoodController: UIViewController, UITextViewDelegate, UITableViewMethdos {
    
    @IBOutlet weak var food_tableView: UITableView!
    @IBOutlet weak var typeFood_segmentedControl: UISegmentedControl!
    @IBOutlet weak var food_textView: UITextView!
    @IBOutlet weak var btn_addFood: UIButton!
    @IBOutlet weak var lbl_switchFoodType: UILabel!
    @IBOutlet weak var foodType_switch: UISwitch!
    @IBOutlet weak var view_switch: UIView!
    
    private var meal = Meal()
    private var foodType: FoodType? = nil
    private let generator1 = UISelectionFeedbackGenerator()
    private let generator2 = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddFoodViewModel.setViewSwitch(view_switch,foodType_switch)
        AddFoodViewModel.setDoneButton(btn_addFood)
        AddFoodViewModel.setTextView(food_textView)
        AddFoodViewModel.setSegmentedControl(typeFood_segmentedControl, &foodType)
        foodType = nil
    }
    
    @IBAction func switch_foodType(_ sender: UISwitch) {
        foodType = sender.isOn ? AddFoodViewModel.setFoodType(typeFood_segmentedControl.selectedSegmentIndex) : nil
        Animation.animateAlpha(typeFood_segmentedControl, sender.isOn)
    }
    
    @IBAction func changeFoodType(_ sender: UISegmentedControl) {
        generator1.selectionChanged()
        AddFoodViewModel.setSegmentedControl(sender, &foodType)
    }
    
    @IBAction func confirmMeal(_ sender: Any) {
        do {
            try week.addMealToday(meal, in: foodDay)
            generator2.notificationOccurred(.success)
        } catch AddMealWarning.alreadyContainsMeal{
            print("ya lo tiene")
        } catch AddMealWarning.todayError {
            print("ketamina")
        } catch AddMealWarning.foodArrayEmpty {
            print("keta x array vacio")
        } catch {
            print("todo mal, no sabemos el error keta")
        }
        
        navigationController?.popViewController(animated: true)
    }
    // MARK: - TEXTS
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.removePlaceholder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            do {
                let food = try AddFoodViewModel.addFood(name: textView.text, type: foodType, meal.getFoodArray())
                meal.addFood(food)
                food_tableView.reloadData()
                textView.makePlaceholder(textViewAddFoodPlaceHolder)
            } catch AddFoodWarning.foodTextEmpty{
                print("vacio")
            } catch AddFoodWarning.alreadyContainsFood {
                print("ya lo tieneee")
            } catch {
                print("ke")
            }
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // MARK: - TABLEVIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meal.getFoodArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addFoodCellid",for: indexPath) as! AddFoodCell
        let reverseFood: [Food] = meal.getFoodArray().reversed()
        cell.setCell(text: reverseFood[indexPath.row].getName(), type: reverseFood[indexPath.row].getType())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return addFoodCellHeight
    }
}
