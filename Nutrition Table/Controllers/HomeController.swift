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
    
    // Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTransparent()
        HomeViewModel.setView(views)
        HomeViewModel.setLabels(lables)
        HomeViewModel.setImages(images)
        HomeViewModel.setTodayViews(containerViews, circleViews, lbl_meals)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setNavigationTransparent()
        HomeViewModel.reloadTodayView(circleViews)
    }
    
    
    @IBAction func export(_ sender: Any) {
        transition(to: exportid)
    }
    
    @IBAction func add(_ sender: Any) {
        transition(to: chooseid)
    }
    
    @IBAction func addRecommended(_ sender: Any) {
        // Food type already set in ViewModel
        transition(to: addFoodid)
    }
    
    @IBAction func today(_ sender: Any) {
        selectedDay = Week.getDay(from: Date()) ?? Day()
        transition(to: dayId)
    }
    
    @IBAction func week(_ sender: Any) {
        transition(to: weekid)
    }
    
    @IBAction func config(_ sender: Any) {
        // go to config
    }
    
    @IBAction func calendar(_ sender: Any) {
        // go to calendar
    }
}

#warning("Ponerle sonidito y vibración")

