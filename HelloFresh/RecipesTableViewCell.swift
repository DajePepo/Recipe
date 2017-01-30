//
//  RecipesTableViewCell.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 29/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var recipeTableCellContainer: UIView! {
        didSet {
            recipeTableCellContainer.layer.cornerRadius = 5
        }
    }
    
    // View model
    var cellModel: RecipeViewModel? {
        didSet {
            bindViewModel()
        }
    }

    // Method used to bind view model properties to table view cell elements
    func bindViewModel() {
        self.nameLabel.text = cellModel?.name
        self.headLineLabel.text = cellModel?.headLine
        self.difficultyLabel.text = cellModel?.difficulty
        //self.pictureImageView = cellModel?.imageUrl
        self.pictureImageView.image = UIImage(named: "imagePlaceholder")
    }

    func configure(model: RecipeViewModel) {
        cellModel = model
        cellModel?.getIsLoved() { self.loveButton.isSelected = $0 ?? false }
    }
    
    @IBAction func didClickOnLoveButton(_ sender: AnyObject) {
        
        // Update the model view variable
        cellModel?.setIsLoved(newValue: !loveButton.isSelected) {
            
            // Then the UI
            loveButton.isSelected = $0 ?? loveButton.isSelected
        }
    }
    
}
