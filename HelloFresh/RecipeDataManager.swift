//
//  RecipeDataManager.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Foundation

public class RecipeDataManager {
    
    func retrieveRecipes() -> [Recipe] {
        
        var recipes = [Recipe]()
        
        // Try to get json file url
        guard let url = Bundle.main.url(forResource: "recipes", withExtension: "json") else {
            print("Error getting json file url")
            return []
        }
        
        do {
            
            // Read json file content
            let data = try Data(contentsOf: url)
            
            if let recipesJson = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                
                // Get recipes stored in json file
                for recipeJson in recipesJson {
                    
                    if  let id = recipeJson["id"] as? String,                       // Id
                        let name = recipeJson["name"] as? String,                   // Name
                        let headLine = recipeJson["headline"] as? String,           // HeadLine
                        let imageUrl = recipeJson["image"] as? String,              // ImageUrl
                        let ingredients = recipeJson["ingredients"] as? [String],   // Ingredients
                        let description = recipeJson["description"] as? String,     // Description
                        let rating = recipeJson["rating"] as? Int?,                 // Rating
                        let difficulty = recipeJson["difficulty"] as? Int,          // Difficulty
                        let time = recipeJson["time"] as? String {                  // Time
                    
                        // Create a recipe model with data got from the json
                        let recipe = Recipe(id: id, name: name, headLine: headLine, imageUrl: imageUrl, ingredients: ingredients, description: description, rating: rating, difficulty: difficulty, time: time)
                        
                        // Add recipe to the result list
                        recipes.append(recipe)
                    }
                }
            }
        }
            
        catch {
            print("Error deserializing json: \(error)")
        }
        
        return recipes
    }
    
    // Save user (:userId) love (:yer or no) about the recipe (:recipeId)
    // Return the saved user love or nil and error message
    func loveRecipe(recipeId: String, userId: String, value: Bool, completion: (_ love: Bool?, _ error: String?) -> Void) {
        if Constants.loveRecipeWillFail { completion(nil, "Error loving the recipe") }
        else { completion(value, nil) }
    }
    
    // Save the recipe rating issued by the user
    // Return the saved rating or nil and error message
    func rateRecipe(recipeId: String, value: Int, userId: String, completion: ( _ rating: Int?, _ error: String?) -> Void) {
        if Constants.rateRecipeWillFail { completion(nil, "Error rating the recipe") }
        else { completion(value, nil) }
    }
    
    // Check if the user loves the recipe
    // Return the user love or nil and error message
    func recipeIsLoved(recipeId: String, byUser userId: String, completion: (_ love: Bool?, _ error: String?) -> Void) {
        if Constants.retrieveUserLoveWillFail { completion(nil, "Error retrieving user love") }
        else {
            let initialUserLove = Constants.wasThereUserLove ? Utils.randomBool() : nil
            completion(initialUserLove, nil)
        }
    }
    
    // Check if the user has already rate the recipe
    // Return user rating or nil and error message
    func retrieveRate(ofUser userId: String, forRecipe recipeId: String, completion: (_ rating: Int?, _ error: String?) -> Void) {
        if Constants.retrieveUserRatingWillFail { completion(nil, "Error retrieving user rating") }
        else {
            let initialUserRating = Constants.wasThereUserRating ? Utils.randomBetwwen(lower: 0, upper: 4) : nil
            completion(initialUserRating, nil)
        }
    }
    
}


