//
//  RecipesTableViewCell.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 29/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

protocol RecipesTableCellDelegate {
    func showLoginView()
}

class RecipesTableViewCell: UITableViewCell {

    // Delegate
    var delegate: RecipesTableCellDelegate?
    
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
    
    func configure(viewModel: RecipeViewModel) {
        cellViewModel = viewModel
        cellViewModel?.retriveUserLove()
    }

    
    // View model
    var cellViewModel: RecipeViewModel? {
        didSet {
            bindViewModel()
        }
    }

    // Method used to bind view model properties to table view cell elements
    func bindViewModel() {
        self.nameLabel.text = cellViewModel?.name
        self.headLineLabel.text = cellViewModel?.headLine
        self.difficultyLabel.text = cellViewModel?.difficulty
        self.pictureImageView.downloadedFrom(link: cellViewModel?.imageUrl)
        if let cellVM = cellViewModel { self.loveButton.isSelected = cellVM.isLoved }
        addObserver(self, forKeyPath: #keyPath(cellViewModel.isLoved), options: .new, context: nil)
    }
    
    
    // Love button action
    @IBAction func didClickOnLoveButton(_ sender: AnyObject) {
        
        // If the user is not logged -> show login form
        if let cellVM = cellViewModel, !cellVM.isUserLogged() {
            delegate?.showLoginView()
            return
        }
        
        cellViewModel?.loveRecipe(newValue: !loveButton.isSelected)
    }
    
    // Override the observer to complete the binding
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(cellViewModel.isLoved) {
            if let cellVM = cellViewModel {
                
                // Set button state according to model view attribute value
                loveButton.isSelected = cellVM.isLoved
            }
        }
    }
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(cellViewModel.isLoved))
    }
}
