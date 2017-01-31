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
    private var userRating: Int?
    

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
            completion(isLoved)
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
        RecipeDataManager.loveRecipe(recipeId: id, value: newValue) { result in
            
            // If it worked -> set private variable
            if result != nil { isLoved = newValue }
            
            // Run completion with newValue or nil (if it returned an error)
            completion(result)
        }
    }

    
    // ...
    func getUserRating(completion: (Int?) -> Void) {
        if let _ = userRating {
            completion(userRating)
        }
        else {
            RecipeDataManager.retrieveRate(ofUser: "", forRecipe: id) { result in
                userRating = result
                completion(userRating)
            }
        }
    }
    
    func rateRecipe(newValue: Int, completion: (Int?) -> Void) {
        RecipeDataManager.rateRecipe(recipeId: id, value: newValue, userId: "") { result in
            userRating = result
            completion(userRating)
        }
    }
    
}
