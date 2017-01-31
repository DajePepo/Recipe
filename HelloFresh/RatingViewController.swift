//
//  RatingViewController.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 30/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

protocol RatingDelegate {
    func updateRating(newValue: Int, completion: (Int?) -> Void)
}

class RatingViewController: UIViewController {
    
    var delegate: RatingDelegate?
    var ratingScore: Int = 0 {
        // Every time the variable changes -> update UI
        didSet {
            selectButtons(rating: ratingScore)
        }
    }
    
    // Buttons panel view
    @IBOutlet weak var buttonsPanel: UIStackView!
    @IBOutlet weak var messageLabel: UILabel!
    
    // Execute when one of the buttons is tapped
    @IBAction func didClickeOnRateButton(_ sender: UIButton) {
        
        // Ask the delegate to update the rating (remote value)
        delegate?.updateRating(newValue: sender.tag) { result in
            
            // If it worked -> update and disable the buttons panel
            if let newValue = result {
                ratingScore = newValue
                messageLabel.text = "Thanks for your feedback"
                messageLabel.isHidden = false
            }
        }
    }
    
    func disableButtonsPanel() {
        buttonsPanel.isUserInteractionEnabled = false
    }
    
    func selectButtons(rating: Int) {
        for view in buttonsPanel.subviews {
            if let button = view as? UIButton {
                if button.tag <= ratingScore { button.isSelected = true }
                else { button.isSelected = false }
            }
        }
        if rating > 0 { disableButtonsPanel() }
    }
    
}
