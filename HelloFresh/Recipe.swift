//
//  Recipe.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

public class Recipe {
    
    var id: String
    var name: String
    var headLine: String
    var imageUrl: String
    var ingredients: [String]
    var description: String
    var rating: Int?
    var difficulty: Int
    var time: String
    
    init(id: String, name: String, headLine: String, imageUrl: String, ingredients: [String], description: String, rating: Int?, difficulty: Int, time: String) {
        self.id = id
        self.name = name
        self.headLine = headLine
        self.imageUrl = imageUrl
        self.ingredients = ingredients
        self.description = description
        self.rating = rating
        self.difficulty = difficulty
        self.time = time
    }
    
}
