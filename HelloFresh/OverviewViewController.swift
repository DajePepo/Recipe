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
    var recipesListViewModel: RecipesListViewModel?
    
    // Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        if let index = selectedRecipeIndex, let recipeMVC = recipesListViewModel {
            
            // Get the overview table from the sub view controllers list
            for viewController in self.childViewControllers {
                if let overviewTVC = viewController as? OverviewTableViewController {
                    
                    // Trick to remove separator between empty cells
                    overviewTVC.tableView.tableFooterView = UIView(frame: CGRect.zero)
                    
                    // Set estimated size of overview table cells
                    overviewTVC.tableView.estimatedRowHeight = 100
                    
                    // Configure the view controller with view model data
                    overviewTVC.configure(viewModel: recipeMVC.recipeViewModel(at: index))
                    
                    // Set the delegate
                    overviewTVC.delegate = self
                }
            }
        }
    }
    
}


// MARK: - Overview table cell delegate

extension OverviewViewController: OverviewTableDelegate {
    
    func showLoginView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            present(loginViewController, animated: true, completion: nil)
        }
    }
}
