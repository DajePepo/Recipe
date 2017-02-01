//
//  ViewController.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

open class RecipesListViewController: UIViewController {
    
    // Variables
    var recipesListViewModel = RecipesListViewModel()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: .valueChanged)
        return refreshControl
    }()
    
    // Outlets
    @IBOutlet weak var recipesTableView: UITableView!
    
    // Life cycle methods
    override open func viewDidLoad() {
        super.viewDidLoad()
     
        // Set dynamic cell size to recipes table
        recipesTableView.rowHeight = UITableViewAutomaticDimension
        recipesTableView.estimatedRowHeight = 265
        
        // Add the custom refresh control to the recipes table
        recipesTableView.addSubview(self.refreshControl)

        // Get recipes list
        recipesListViewModel.retrieveRecipes()
        
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        recipesTableView.reloadData()
    }
    
    // Refresh table data
    func handleRefresh(refreshControl: UIRefreshControl) {
        recipesListViewModel.retrieveRecipes()
        recipesTableView.reloadData()
        refreshControl.endRefreshing()
    }

    // Routing
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let overviewVC = segue.destination as? OverviewViewController {
            
            // Set view model controller and selected recipe index in the overview view controller
            overviewVC.recipesListViewModel = recipesListViewModel
            overviewVC.selectedRecipeIndex = recipesTableView.indexPathForSelectedRow?.row
        }
    }
}


// MARK: - Table view delegate

extension RecipesListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "fromRecipesToOverview", sender: nil)
    }
}


// MARK: - Table view data source

extension RecipesListViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesListViewModel.recipesCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesTableViewCell", for: indexPath) as? RecipesTableViewCell
        guard let recipeCell = cell else { return UITableViewCell() }
        recipeCell.configure(viewModel: recipesListViewModel.recipeViewModel(at: (indexPath as NSIndexPath).row))
        recipeCell.delegate = self
        return recipeCell
    }
}


// MARK: - Recipes table cell delegate

extension RecipesListViewController: RecipesTableCellDelegate {
    
    func showLoginView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            present(loginViewController, animated: true, completion: nil)
        }
    }
    
    func showErrorMessage(message: String) {
        showMessage(message: "There was an error.\nPlease try again.", completionHandler: nil)
    }
}

