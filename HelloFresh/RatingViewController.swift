//
//  RatingViewController.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 30/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

protocol RatingDelegate {
    func updateRating(newValue: Int, success: (Int?) -> Void)
}

class RatingViewController: UIViewController {
    
    var delegate: RatingDelegate?
    var ratingScore: Int = 0 {
        // Every time the variable changes -> update UI
        didSet {
            for view in buttonsPanel.subviews {
                if let button = view as? UIButton {
                    if button.tag <= ratingScore { button.isSelected = true }
                    else { button.isSelected = false }
                }
            }
        }
    }
    
    // Buttons panel view
    @IBOutlet weak var buttonsPanel: UIStackView!
    
    // Execute when one of the buttons is tapped
    @IBAction func didClickeOnRateButton(_ sender: UIButton) {
        
        // Ask the delegate to update the rating (remote value)
        delegate?.updateRating(newValue: sender.tag) { result in
            
            // If it worked -> update the local value
            if let newValue = result {
                ratingScore = newValue
            }
        }
    }
    
    func disableButtons() {
        for view in buttonsPanel.subviews {
            if let button = view as? UIButton {
                button.isEnabled = false
            }
        }
    }
    
}
