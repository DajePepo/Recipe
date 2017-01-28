//
//  RecipeDataManager.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Foundation

public class RecipeDataManager {
    
    static func retrieveRecipes() -> [Recipe]? {
        
        var recipes: [Recipe]?
        
        // Try to get json file url
        guard let url = Bundle.main.url(forResource: "recipes", withExtension: "json") else {
            print("Error getting json file url")
            return nil
        }
        
        do {
            
            // Read json file content
            let data = try Data(contentsOf: url)
            
            if let recipesJson = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                
                recipes = [Recipe]()
                
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
                        recipes?.append(recipe)
                    }
                }
            }
        }
            
        catch {
            print("Error deserializing json: \(error)")
        }
        
        return recipes
    }
    
    static func loveRecipe(recipeId: String, succes: () -> Void, fail: () -> Void) {
        fail()
    }
    
    static func rateRecipe(recipeId: String, succes: () -> Void, fail: () -> Void) {
        fail()
    }
    
    static func recipeIsLoved(byUser userEmail: String, succes: (Bool) -> Void, fail: () -> Void) {
        fail()
    }
    
    static func retrieveRate(ofUser userEmail: String, forRecipe recipeId: String, succes: (Int) -> Void, fail: () -> Void) {
        
    }
    
}


