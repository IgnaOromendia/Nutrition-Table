//
//  HomeController.swift
//  Nutrition Table
//
//  Created by Igna on 22/06/2021.
//

import UIKit

class HomeController: UIViewController {
    
//    @IBOutlet weak var view_days: UIView!
//    @IBOutlet weak var view_snack1: UIView!
//    @IBOutlet weak var view_snack2: UIView!
//    @IBOutlet weak var view_lunch: UIView!
//    @IBOutlet weak var view_afternoon: UIView!
//    @IBOutlet weak var view_dinner: UIView!
    
    // VIEW TODAY
    
    @IBOutlet weak var view_today: UIView!
    @IBOutlet var containerViews: [UIView]! // Outlet Collection
    @IBOutlet var circleViews: [UIView]! // Outlet Collection
    @IBOutlet var lbl_meals: [UILabel]! // Outlet Collection
    @IBOutlet weak var lbl_titleToday: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    
    // VIEW ADD RECOMMENDED
    
    @IBOutlet weak var view_addRecommended: UIView!
    @IBOutlet weak var im_addRecommended: UIImageView!
    @IBOutlet weak var lbl_titleAddRecommended: UILabel!

    // VIEW EXPORT
    
    @IBOutlet weak var view_export: UIView!
    @IBOutlet weak var lbl_titleExport: UILabel!
    @IBOutlet weak var im_export: UIImageView!
    
    // VIEW ADD
    
    @IBOutlet weak var view_add: UIView!
    @IBOutlet weak var lbl_titleAdd: UILabel!
    @IBOutlet weak var im_add: UIImageView!
    
    // VIEW WEEK
    
    @IBOutlet weak var view_week: UIView!
    @IBOutlet weak var lbl_titleWeek: UILabel!
    
    // VIEW CALENDAR
    
    @IBOutlet weak var view_calendar: UIView!
    @IBOutlet weak var lbl_titleCalendar: UILabel!
    @IBOutlet weak var im_calendar: UIImageView!
    
    // VIEW CONFIGURATION
    
    @IBOutlet weak var view_config: UIView!
    @IBOutlet weak var im_congif: UIImageView!
    
    // Vars
    
    lazy var views: [UIView] = {
        return [view_today,view_addRecommended,view_export,
                view_add,view_week,view_config,view_calendar]
    }()
    
    lazy var lables: [UILabel] = {
        return [lbl_titleToday,lbl_date,lbl_titleAddRecommended,
                lbl_titleExport,lbl_titleAdd,lbl_titleWeek,lbl_titleCalendar]
    }()
    
    lazy var images: [UIImageView] = {
        return [im_addRecommended,im_export,im_add,im_congif,im_calendar]
    }()
    
    lazy var circleViewsReference: [String:UIView?] = {
        return ["Breakfast":circleViews.withTag(1), "Snack1":circleViews.withTag(2), "Lunch":circleViews.withTag(3), "Snack2":circleViews.withTag(4), "Afternoon snack":circleViews.withTag(5), "Dinner":circleViews.withTag(6)]
    }()
    
    // Controller
    
    let stManager = StorgareManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        HomeViewModel.setView(views)
        HomeViewModel.setLabels(lables)
        HomeViewModel.setImages(images)
        HomeViewModel.setTodayViews(containerViews, circleViewsReference, lbl_meals)
        HomeViewModel.setAdjustableFontSize([lbl_titleWeek, lbl_titleAddRecommended])
        let id = "\(Date().getWeekMondayDate().storageDate)-Monday"
        week = stManager.readWeekData(id: id)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        HomeViewModel.reloadTodayView(circleViewsReference)
    }
    
    
    @IBAction func export(_ sender: Any) {
        transition(to: exportid)
    }
    
    @IBAction func add(_ sender: Any) {
        selectedDay = week.today ?? Day()
        transition(to: chooseid)
    }
    
    @IBAction func addRecommended(_ sender: Any) {
        selectedDay = week.today ?? Day()
        HomeViewModel.setDayFoodType()
        transition(to: addFoodid)
    }
    
    @IBAction func today(_ sender: Any) {
        selectedDay = week.today ?? Day()
        transition(to: dayId)
    }
    
    @IBAction func weekA(_ sender: Any) {
        transition(to: weekid)
    }
    
    @IBAction func config(_ sender: Any) {
        // go to config
    }
    
    @IBAction func calendar(_ sender: Any) {
        // go to calendar
    }
    
}
