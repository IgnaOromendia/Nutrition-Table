//
//  Nutrition_TableTests.swift
//  Nutrition TableTests
//
//  Created by Igna on 15/06/2021.
//

import XCTest
@testable import Nutrition_Table

class Nutrition_TableTests: XCTestCase {
    
    // MARK: - ADD FOOD TESTS
    func test_valid_case() throws {
        let foodExpected = Food(name: "Carne", type: .protein)
        let foodOut = try AddFoodViewModel.addFood(name: "Carne", type: .protein, [])
        XCTAssertEqual(foodExpected.getName(), foodOut.getName())
    }
    
    func test_empty_name() throws {
        let errorExcpected = AddFoodWarning.foodTextEmpty
        var error: AddFoodWarning?

        XCTAssertThrowsError(try AddFoodViewModel.addFood(name: "", type: .protein, [])) { thrownError in
            error = thrownError as? AddFoodWarning
        }
        
        XCTAssertEqual(errorExcpected, error)
    }
    
    func test_food_already_inArray() throws {
        let array = [Food(name: "Carne", type: .protein)]
        let errorExcpected = AddFoodWarning.alreadyContainsFood
        var error: AddFoodWarning?
        
        XCTAssertThrowsError(try AddFoodViewModel.addFood(name: "Carne", type: .protein, array)) { errorThrown in
            error = errorThrown as? AddFoodWarning
        }
        
        XCTAssertEqual(errorExcpected, error)
    }
    
    // MARK: - DATA MANAGER TESTS
    
    func test_updateFoodData() throws {
        let excpected: [DayFoodType:[String:Int]] = [.breakfast:["Cafe":3],.lunch:["Carne":1]]
        let foodData: [DayFoodType:[String:Int]] = [.breakfast:["Cafe":2]]
        let foodBreakfast = [Food(name: "Cafe")]
        let foodLunch = [Food(name: "Carne")]
        
        let dataManager = DataManager()
        
        dataManager.setFoodData(data: foodData)
        
        dataManager.updateFoodData(with: foodBreakfast, at: .breakfast)
        dataManager.updateFoodData(with: foodLunch, at: .lunch)
        
        XCTAssertEqual(dataManager.getFoodData(), excpected)
    }
    
    func test_topMostEatenSimpleCase() throws {
        let excpected: [Food] = [Food(name: "A")]
        let foodData: [DayFoodType:[String:Int]] = [.lunch:["A":10]]
        let dataManager = DataManager()
        dataManager.setFoodData(data: foodData)
        XCTAssertEqual(dataManager.topMostEaten(at: .lunch), excpected)
    }
    
    func test_topMostEatenJustTwoCase() throws {
        let excpected: [Food] = [Food(name: "A"),Food(name: "B")]
        let foodData: [DayFoodType:[String:Int]] = [.lunch:["A":10,"B":4]]
        let dataManager = DataManager()
        dataManager.setFoodData(data: foodData)
        XCTAssertEqual(dataManager.topMostEaten(at: .lunch), excpected)
    }
    
    func test_topMostEatenExactCase() throws {
        let excpected: [Food] = [Food(name: "A"),Food(name: "B"),Food(name: "C")]
        let foodData: [DayFoodType:[String:Int]] = [.lunch:["A":10,"C":1,"B":4]]
        let dataManager = DataManager()
        dataManager.setFoodData(data: foodData)
        XCTAssertEqual(dataManager.topMostEaten(at: .lunch), excpected)
    }
    
    func test_topMostEatenCompleteCase() throws {
        let excpected: [Food] = [Food(name: "A"),Food(name: "B"),Food(name: "C")]
        let foodData: [DayFoodType:[String:Int]] = [.lunch:["A":10,"C":3,"B":7,"D":1]]
        let dataManager = DataManager()
        dataManager.setFoodData(data: foodData)
        XCTAssertEqual(dataManager.topMostEaten(at: .lunch), excpected)
    }
    
    func test_topMostEatenDrawCase() throws {
        let excpected: [Food] = [Food(name: "A"),Food(name: "B")]
        let foodData: [DayFoodType:[String:Int]] = [.lunch:["A":10,"B":10]]
        let dataManager = DataManager()
        dataManager.setFoodData(data: foodData)
        XCTAssertTrue(dataManager.topMostEaten(at: .lunch).contains(excpected[0]) &&
                      dataManager.topMostEaten(at: .lunch).contains(excpected[1]))
    }
    
}

