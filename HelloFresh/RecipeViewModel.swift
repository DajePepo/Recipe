//
//  RecipeViewModel.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

public struct RecipeViewModel {
    
    var id: String
    var name: String
    var headLine: String
    var imageUrl: String
    var ingredients: [String]
    var description: String
    var rating: Int?
    var difficulty: Int
    var time: String

    
}
