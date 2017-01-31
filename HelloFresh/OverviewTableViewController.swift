//
//  OverviewTableViewController.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 29/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

class OverviewTableViewController: UITableViewController {

    // Outlets
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var ratingStatusLabel: UILabel!
    @IBOutlet weak var ratingButtonsContainer: UIView!
    @IBOutlet weak var loveButton: UIButton!
    
    // Action
    @IBAction func didClickOnLoveButton(_ sender: Any) {
        
        // Update the model view variable
        tableModel?.setIsLoved(newValue: !loveButton.isSelected) {
            
            // Then the UI
            loveButton.isSelected = $0 ?? loveButton.isSelected
        }
    }
    
    
    // View model
    var tableModel: RecipeViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    
    // Method used to bind view model properties to table view elements
    func bindViewModel() {
        self.nameLabel.text = tableModel?.name
        self.headLineLabel.text = tableModel?.headLine
        self.difficultyLabel.text = tableModel?.difficulty
        self.timeLabel.text = tableModel?.time
        self.ingredientsLabel.text = tableModel?.ingredients
        self.descriptionLabel.text = tableModel?.description
        self.ratingStatusLabel.text =  tableModel?.rating
        self.pictureImageView.downloadedFrom(link: tableModel?.imageUrl)
    }
    
    func configure(model: RecipeViewModel) {

        // Set model view
        tableModel = model
        
        // Set love button state
        model.getIsLoved { loveButton.isSelected = $0 ?? false }
        
        // Get the rating buttons panel from the sub view controllers list
        for viewController in self.childViewControllers {
            if let ratingVC = viewController as? RatingViewController {

                // Set rating delegate
                ratingVC.delegate = self

                // Set user rating
                model.getUserRating { result in
                    if let value = result, value > 0 {
                        ratingVC.ratingScore = value
                        ratingVC.messageLabel.text = "You have already rated this recipe"
                        ratingVC.messageLabel.isHidden = false
                    }
                }
            }
        }
    }

}


// MARK: - Table view data source

extension OverviewTableViewController  {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}


// MARK: - Rating delegate

extension OverviewTableViewController: RatingDelegate {
    
    func updateRating(newValue: Int, completion: (Int?) -> Void) {
        tableModel?.rateRecipe(newValue: newValue) { completion($0) }
    }
}

