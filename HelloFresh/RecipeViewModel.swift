//
//  RecipeViewModel.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Foundation

class RecipeViewModel: NSObject, UserProtocol {
    
    var id: String
    var name: String
    var headLine: String
    var imageUrl: String
    var ingredients: String
    var info: String
    var difficulty: String
    var time: String
    var rating: String?
    
    var userRatingNotUpdated = true
    dynamic var userRating: Int = 0
    dynamic var ratingConfirmationMessage: String = ""
    
    var isLoveNotUpdated = true
    dynamic var isLoved: Bool = false
    

    // Initialize the view model through the model
    init(recipe: Recipe) {
        self.id = recipe.id
        self.name = recipe.name
        self.headLine = recipe.headLine
        self.imageUrl = recipe.imageUrl
        self.info = recipe.description
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
    
    
    // Check if user loves the recipe
    func retriveUserLove() {
        if isLoveNotUpdated, let userId = getLoggedUserId() {
            RecipeDataManager.recipeIsLoved(recipeId: id, byUser: userId) { result in
                isLoved = result ?? false
                isLoveNotUpdated = (result != nil) ? false : true
            }
        }
    }
    
    // Rate the recipe
    func loveRecipe(newValue: Bool) {
        if let userId = getLoggedUserId() {
            RecipeDataManager.loveRecipe(recipeId: id, userId: userId, value: newValue) { result in
                if result != nil { isLoved = newValue }
            }
        }
    }


    // Retrieve initial user value
    func retriveUserRating() {
        if userRatingNotUpdated, let userId = getLoggedUserId() {
            RecipeDataManager.retrieveRate(ofUser: userId, forRecipe: id) { result in
                if let rating = result {
                    userRating = rating
                    ratingConfirmationMessage = "You have already rated this recipe"
                    userRatingNotUpdated = false
                }
            }
        }
    }
    
    // Rate the recipe
    func rateRecipe(newValue: Int) {
        if let userId = getLoggedUserId() {
            RecipeDataManager.rateRecipe(recipeId: id, value: newValue, userId: userId) { result in
                if let rating = result {
                    userRating = rating
                    ratingConfirmationMessage = "Thanks for your feedback"
                }
            }
        }
    }
    
}
