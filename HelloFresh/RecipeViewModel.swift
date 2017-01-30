//
//  RecipeViewModel.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//


class RecipeViewModel {
    
    var id: String
    var name: String
    var headLine: String
    var imageUrl: String
    var ingredients: String
    var description: String
    var difficulty: String
    var time: String
    var rating: String?
    
    private var isLoved: Bool?
    var userRating: String?
    

    // Initialize the view model through the model
    init(recipe: Recipe) {
        self.id = recipe.id
        self.name = recipe.name
        self.headLine = recipe.headLine
        self.imageUrl = recipe.imageUrl
        self.description = recipe.description
        self.difficulty = "level \(recipe.difficulty)"
        self.rating = (recipe.rating != nil) ? "Avarage rating is \(recipe.rating!)" : "No Rating Yet"
        self.time = {
            let index = recipe.time.index(recipe.time.startIndex, offsetBy: 2)
            return recipe.time.substring(from: index).lowercased()
        }()
        self.ingredients = {
            var value = ""
            for ingredient in recipe.ingredients { value += ingredient + "\n" }
            return value
        }()
    }
    
    // Get "isLoved" property
    func getIsLoved(completion: (Bool?) -> Void) {
        if let _ = isLoved {
            return completion(isLoved)
        }
        else {
            RecipeDataManager.recipeIsLoved(recipeId: id, byUser: "") { result in
                isLoved = result
                completion(isLoved)
            }
        }
    }
    

    // Set "isLoved" property
     func setIsLoved(newValue: Bool, completion: (Bool?) -> Void) {
        
        // Ask data manager to update the value (remote value)
        RecipeDataManager.loveRecipe(recipeId: id, value: newValue, success: {
            
            // If it worked -> set private variable and run completion with newValue
            isLoved = newValue
            completion(newValue)
        }, fail: {
            
            // If no -> run completion with nil value and print the error
            completion(nil)
            print("Error loving the recipe")
        })
    }

}


extension RecipeViewModel: RatingDelegate {
    func updateRating(newValue: Int, success: (Int?) -> Void) {
        success(newValue)
    }
}
