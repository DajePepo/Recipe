//
//  OverviewTableViewController.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 29/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

protocol OverviewTableDelegate {
    func showLoginView()
}

class OverviewTableViewController: UITableViewController {

    // Delegate
    var delegate: OverviewTableDelegate?
    
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
    
    // Configure method -> it's called as first to initialize the table view controller
    func configure(viewModel: RecipeViewModel) {
        
        // Set model view
        tableViewModel = viewModel
        
        // Get the rating buttons panel from the sub view controllers list
        for viewController in self.childViewControllers {
            if let ratingVC = viewController as? RatingViewController {
                ratingVC.configure(viewModel: tableViewModel)
                ratingVC.delegate = self
            }
        }
    }

    
    // View model
    var tableViewModel: RecipeViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    // Method used to bind view model properties to table view elements
    func bindViewModel() {
        self.nameLabel.text = tableViewModel?.name
        self.headLineLabel.text = tableViewModel?.headLine
        self.difficultyLabel.text = tableViewModel?.difficulty
        self.timeLabel.text = tableViewModel?.time
        self.ingredientsLabel.text = tableViewModel?.ingredients
        self.descriptionLabel.text = tableViewModel?.info
        self.ratingStatusLabel.text =  tableViewModel?.rating
        self.pictureImageView.downloadedFrom(link: tableViewModel?.imageUrl)
        if let tableVM = tableViewModel { self.loveButton.isSelected = tableVM.isLoved }
        addObserver(self, forKeyPath: #keyPath(tableViewModel.isLoved), options: .new, context: nil)
    }
    
    // Love action
    @IBAction func didClickOnLoveButton(_ sender: Any) {
        
        // If the user is not logged -> show login form
        if let viewModel = tableViewModel, !viewModel.defaultsManager.isUserLogged() {
            delegate?.showLoginView()
            return
        }
        
        tableViewModel?.loveRecipe(newValue: !loveButton.isSelected, fail: { [unowned self] _ in
            
            // If the action failed
            self.showMessage(message: "There was an error.\nPlease try again.", completionHandler: nil)
        })
    }
    
    // Override the observer to complete the binding
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(tableViewModel.isLoved) {
            if let tableVM = tableViewModel {
                
                // Set button state according to model view attribute value
                loveButton.isSelected = tableVM.isLoved
            }
        }
    }
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(tableViewModel.isLoved))
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
    
    func showLoginView() {
        delegate?.showLoginView()
    }
}

