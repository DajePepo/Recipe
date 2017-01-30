//
//  RecipeViewModelController.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 29/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

class RecipeViewModelController {
    
    fileprivate var recipeViewModelList = [RecipeViewModel]()
    
    // Return number of recipes in the list
    var recipesCount: Int {
        return recipeViewModelList.count
    }
    
    // Return a specific recipe (View Model)
    func recipeViewModel(at index: Int) -> RecipeViewModel {
        return recipeViewModelList[index]
    }
    
    // Load recipes list through the data manager
    func retrieveRecipes() {
        let recipes = RecipeDataManager.retrieveRecipes()
        self.recipeViewModelList = recipes.map(){ RecipeViewModel(recipe: $0) }
    }

    // Check
    
}
