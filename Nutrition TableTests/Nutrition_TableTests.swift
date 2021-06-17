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
        XCTAssertEqual(foodExpected.name, foodOut.name)
    }
    
    func test_empty_name() throws {
        let errorExcpected = AddFoodWarningType.foodTextEmpty
        var error: AddFoodWarningType?

        XCTAssertThrowsError(try AddFoodViewModel.addFood(name: "", type: .protein, [])) { thrownError in
            error = thrownError as? AddFoodWarningType
        }
        
        XCTAssertEqual(errorExcpected, error)
    }
    
    func test_food_already_inArray() throws {
        let array = [Food(name: "Carne", type: .protein)]
        let errorExcpected = AddFoodWarningType.alreadyContainsFood
        var error: AddFoodWarningType?
        
        XCTAssertThrowsError(try AddFoodViewModel.addFood(name: "Carne", type: .protein, array)) { errorThrown in
            error = errorThrown as? AddFoodWarningType
        }
        
        XCTAssertEqual(errorExcpected, error)
    }
    
    // MARK: - MODEL DAY TESTS
    
    func test_getFood_validateCase() {
        let foodExcpected = Food(name: "Carne", type: .protein)
        let foodExcpected2 = Food(name: "Pasta", type: .carbohydrates)
        let mealExcpected = Meal(foods: [foodExcpected], drink: nil)
        let mealExcpected2 = Meal(foods: [foodExcpected2], drink: nil)
        let day = Day(breakfast: mealExcpected2, snaks: nil, lunch: mealExcpected, dinner: nil, afternoonSnak: nil, date: Date())
        let meal = day.getFood(tipo: .lunch)
        let meals = day.getAllFoods()
        
        XCTAssertEqual(mealExcpected, meal)
        XCTAssertEqual([.lunch:mealExcpected,.breakfast:mealExcpected2], meals!)
    }
    
    func test_getNilFood() {
        let day = Day()
        let meal = day.getFood(tipo: .lunch)
        let meals = day.getAllFoods()
        
        XCTAssertNil(meal)
        XCTAssertNil(meals)
    }
    
    
}

