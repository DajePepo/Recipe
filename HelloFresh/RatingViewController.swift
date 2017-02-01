//
//  RatingViewController.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 30/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

protocol RatingDelegate {
    func showLoginView()
}

class RatingViewController: UIViewController {
    
    // Variables
    var delegate: RatingDelegate?
    
    // Outlets
    @IBOutlet weak var buttonsPanel: UIStackView! // Buttons panel
    @IBOutlet weak var removeUserRating: UIButton!
    
    // Configure method -> it's called as first to initialize the view controller
    func configure(viewModel: RecipeViewModel?) {
        ratingViewModel = viewModel
        ratingViewModel?.retriveUserRating()
    }
    
    // View model
    var ratingViewModel: RecipeViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    // Bind view model
    func bindViewModel() {
        addObserver(self, forKeyPath: #keyPath(ratingViewModel.userRating), options: .new, context: nil)
    }
    
    // Execute when one of the buttons is tapped
    @IBAction func didClickOnRateButton(_ sender: UIButton) {
        
        // If the user is not logged -> show login form
        if let ratingVM = ratingViewModel, !ratingVM.defaultsManager.isUserLogged() {
            delegate?.showLoginView()
            return
        }
        
        // Ask the delegate to update the rating
        ratingViewModel?.rateRecipe(newValue: sender.tag, fail: { [unowned self] _ in
            
            // If the action fail
            self.showMessage(message: "There was an error.\nPlease try again.", completionHandler: nil)
        })
    }
    
    @IBAction func didClickOnRemoveRatingButton(_ sender: Any) {
        
        // Ask the delegate to update the rating to zero (no value)
        ratingViewModel?.rateRecipe(newValue: 0,
            success:{ [unowned self] _ in
                self.showMessage(message: "Feedback removed correctly.", completionHandler: nil)
            },
            fail: { [unowned self] _ in
                self.showMessage(message: "There was an error.\nPlease try again.", completionHandler: nil)
            })
    }
    
    // Override the observer to complete the binding
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(ratingViewModel.userRating) {
            if let vM = ratingViewModel {
                
                // Select/Unselect the buttons
                selectButtons(rating: vM.userRating)
                
                // Show/hide a confirmation message
                removeUserRating.isHidden = vM.userRating > 0 ? false : true
            }
        }
    }
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(ratingViewModel.userRating))
    }

    // Buttons methods (select, disable all)
    func selectButtons(rating: Int) {
        for view in buttonsPanel.subviews {
            if let button = view as? UIButton {
                if button.tag <= rating { button.isSelected = true }
                else { button.isSelected = false }
            }
        }
        if rating > 0 { disableButtonsPanel() }
        else { enableButtonsPanel() }
    }

    func disableButtonsPanel() {
        buttonsPanel.isUserInteractionEnabled = false
    }

    func enableButtonsPanel() {
        buttonsPanel.isUserInteractionEnabled = true
    }

}
