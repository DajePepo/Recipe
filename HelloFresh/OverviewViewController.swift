//
//  OverviewViewController.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 29/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {

    // Variables
    var selectedRecipeIndex: Int?
    var recipeViewModelController: RecipeViewModelController?
    
    // Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        if let index = selectedRecipeIndex, let recipeMVC = recipeViewModelController {
            
            // Get the overview table from the sub view controllers list
            for viewController in self.childViewControllers {
                if let overviewTVC = viewController as? OverviewTableViewController {
                    
                    // Trick to remove separator between empty cells
                    overviewTVC.tableView.tableFooterView = UIView(frame: CGRect.zero)
                    
                    // Set estimated size of overview table cells
                    overviewTVC.tableView.estimatedRowHeight = 100
                    
                    // Configure the view controller with view model data
                    overviewTVC.configure(model: recipeMVC.recipeViewModel(at: index))
                }
            }
        }
    }
    
}
