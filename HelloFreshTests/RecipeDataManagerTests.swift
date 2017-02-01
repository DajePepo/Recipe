//
//  RecipeListDataProviderTests.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 01/02/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import XCTest
@testable import HelloFresh

class RecipeDataManagerTests: XCTestCase {
    
    var recipeDataManager: RecipeDataManager!
    
    override func setUp() {
        super.setUp()
        recipeDataManager = RecipeDataManager()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRecipesListHasItems() {
        let recipesList = recipeDataManager.retrieveRecipes()
        XCTAssertGreaterThan(recipesList.count, 0, "Recipes list didn't have at least one item")
    }

}
