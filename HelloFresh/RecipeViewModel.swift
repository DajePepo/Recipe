//
//  RecipeViewModel.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Foundation

class RecipeViewModel: NSObject {
    
    // Variables
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
    var recipeDataManager = RecipeDataManager()
    var defaultsManager = UserDefaultsManager()

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
    func retriveUserLove(completion: (() -> Void)? = nil) {
        if isLoveNotUpdated, let userId = defaultsManager.getLoggedUserId() {
            recipeDataManager.recipeIsLoved(recipeId: id, byUser: userId) { (result, error) in
                isLoved = result ?? false
                isLoveNotUpdated = (result != nil) ? false : true
                completion?()
            }
        }
        else { completion?() }
    }
    
    // Rate the recipe
    func loveRecipe(newValue: Bool, success: (() -> Void)? = nil, fail: (() -> Void)? = nil) {
        if let userId = defaultsManager.getLoggedUserId() {
            recipeDataManager.loveRecipe(recipeId: id, userId: userId, value: newValue) { (result, error) in
                if result != nil {
                    isLoved = newValue
                    success?()
                }
                else { fail?() }
            }
        }
        else { fail?() }
    }

    // Retrieve initial user value
    func retriveUserRating(completion: (() -> Void)? = nil) {
        if userRatingNotUpdated, let userId = defaultsManager.getLoggedUserId() {
            recipeDataManager.retrieveRate(ofUser: userId, forRecipe: id) { (result, error) in
                if let rating = result {
                    userRating = rating
                    ratingConfirmationMessage = "You have already rated this recipe"
                    userRatingNotUpdated = false
                }
                completion?()
            }
        }
        else { completion?() }
    }
    
    // Rate the recipe
    func rateRecipe(newValue: Int, success: (() -> Void)? = nil, fail: (() -> Void)? = nil) {
        if let userId = defaultsManager.getLoggedUserId() {
            recipeDataManager.rateRecipe(recipeId: id, value: newValue, userId: userId) { (result, error) in
                if let rating = result {
                    userRating = rating
                    ratingConfirmationMessage = "Thanks for your feedback"
                    success?()
                }
                else { fail?() }
            }
        }
        else { fail?() }
    }
}
