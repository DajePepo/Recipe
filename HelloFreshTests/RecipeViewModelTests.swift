//
//  RecipesListViewControllerTests.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 01/02/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit
import XCTest
@testable import HelloFresh

class RecipeViewModelTests: XCTestCase {
    
    var recipesViewModel: RecipesListViewModel!
    
    override func setUp() {
        super.setUp()
        recipesViewModel = RecipesListViewModel()
        recipesViewModel.retrieveRecipes()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRecipesListHasItems() {
        XCTAssertGreaterThan(recipesViewModel.recipesCount, 0, "Recipes list didn't have at least one item")
    }
    
    func testInitialLoveIsRight() {
        
        for i in 0..<recipesViewModel.recipesCount {
            
            let recipeViewModel = recipesViewModel.recipeViewModel(at: i)
            let dataManager = MockRecipeDataManager()
            recipeViewModel.recipeDataManager = dataManager
            recipeViewModel.defaultsManager = MockUserDefaultsManager()
            
            var expectationWithDescription: XCTestExpectation? = expectation(description: "expectation_\(i)")
            recipeViewModel.retriveUserLove() {
                expectationWithDescription?.fulfill()
                expectationWithDescription = nil
            }
            waitForExpectations(timeout: 5) { _ in
                XCTAssert(recipeViewModel.isLoved == dataManager.userLoveInitialValue, "Recipe \(i) didn't have the right love initial value")
            }
        }
    }

    func testLoveChangedCorrectly() {
        
        let newLoveValue = true
        let randomIndex = Utils.randomBetwwen(lower: 0, upper: UInt32(recipesViewModel.recipesCount))
        let recipeViewModel = recipesViewModel.recipeViewModel(at: randomIndex)
        recipeViewModel.recipeDataManager = MockRecipeDataManager()
        recipeViewModel.defaultsManager = MockUserDefaultsManager()
        
        var expectationWithDescription: XCTestExpectation? = expectation(description: "expectation")
        recipeViewModel.loveRecipe(newValue: newLoveValue, success: {
            expectationWithDescription?.fulfill()
            expectationWithDescription = nil
        }, fail: {
            expectationWithDescription?.fulfill()
            expectationWithDescription = nil
        })
        waitForExpectations(timeout: 5) { _ in
            XCTAssert(recipeViewModel.isLoved == newLoveValue, "Recipe love didn't update correctly")
        }
    }

    func testInitialRatingIsRight() {
        
        
        for i in 0..<recipesViewModel.recipesCount {
            
            let recipeViewModel = recipesViewModel.recipeViewModel(at: i)
            let dataManager = MockRecipeDataManager()
            recipeViewModel.recipeDataManager = MockRecipeDataManager()
            recipeViewModel.defaultsManager = MockUserDefaultsManager()
            
            var expectationWithDescription: XCTestExpectation? = expectation(description: "expectation_\(i)")
            recipeViewModel.retriveUserRating() {
                expectationWithDescription?.fulfill()
                expectationWithDescription = nil
            }
            waitForExpectations(timeout: 5) { _ in
                XCTAssert(recipeViewModel.userRating == dataManager.userRatingInitialValue, "Recipe \(i) didn't have the right rating initial value")
            }
        }
    }
    
    func testRatingChangedCorrectly() {
        
        let newRatingValue = 2
        let randomIndex = Utils.randomBetwwen(lower: 0, upper: UInt32(recipesViewModel.recipesCount))
        let recipeViewModel = recipesViewModel.recipeViewModel(at: randomIndex)
        recipeViewModel.recipeDataManager = MockRecipeDataManager()
        recipeViewModel.defaultsManager = MockUserDefaultsManager()
        
        var expectationWithDescription: XCTestExpectation? = expectation(description: "expectation")
        recipeViewModel.rateRecipe(newValue: newRatingValue, success: {
            expectationWithDescription?.fulfill()
            expectationWithDescription = nil
        }, fail: {
            expectationWithDescription?.fulfill()
            expectationWithDescription = nil
        })
        waitForExpectations(timeout: 5) { _ in
            XCTAssert(recipeViewModel.userRating == newRatingValue, "Recipe user rating didn't update correctly")
        }
    }    
    
    class MockRecipeDataManager: RecipeDataManager {
        
        let userLoveInitialValue = true
        let userRatingInitialValue = 3
        
        override func retrieveRecipes() -> [Recipe] {
            return [Recipe]()
        }
        
        override func loveRecipe(recipeId: String, userId: String, value: Bool, completion: (_ love: Bool?, _ error: String?) -> Void) {
            completion(value, nil)
        }
        
        override func rateRecipe(recipeId: String, value: Int, userId: String, completion: ( _ rating: Int?, _ error: String?) -> Void) {
            completion(value, nil)
        }
        
        override func recipeIsLoved(recipeId: String, byUser userId: String, completion: (_ love: Bool?, _ error: String?) -> Void) {
            completion(userLoveInitialValue, nil)
        }
        
        override func retrieveRate(ofUser userId: String, forRecipe recipeId: String, completion: (_ rating: Int?, _ error: String?) -> Void) {
            completion(userRatingInitialValue, nil)
        }
    }
    
    class MockUserDefaultsManager: UserDefaultsManager {
        
        override func isUserLogged() -> Bool {
            return true
        }
        
        override func getLoggedUserId() -> String? {
            return "ID_000"
        }
    }
    
}


