//
//  ViewController.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

class RecipesListViewController: UIViewController {
    
    // Variables
    var recipesListViewModel = RecipesListViewModel()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: .valueChanged)
        return refreshControl
    }()
    
    // Outlets
    @IBOutlet weak var recipesTableView: UITableView!
    
    // File cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Set dynamic cell size to recipes table
        recipesTableView.rowHeight = UITableViewAutomaticDimension
        recipesTableView.estimatedRowHeight = 265
        
        // Add the custom refresh control to the recipes table
        recipesTableView.addSubview(self.refreshControl)

        // Get recipes list
        recipesListViewModel.retrieveRecipes()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipesTableView.reloadData()
    }
    
    // Refresh table data
    func handleRefresh(refreshControl: UIRefreshControl) {
        recipesListViewModel.retrieveRecipes()
        recipesTableView.reloadData()
        refreshControl.endRefreshing()
    }

    // Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let overviewVC = segue.destination as? OverviewViewController {
            
            // Set view model controller and selected recipe index in the overview view controller
            overviewVC.recipesListViewModel = recipesListViewModel
            overviewVC.selectedRecipeIndex = recipesTableView.indexPathForSelectedRow?.row
        }
    }


}


// MARK: - Table view delegate

extension RecipesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "fromRecipesToOverview", sender: nil)
    }
}


// MARK: - Table view data source

extension RecipesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesListViewModel.recipesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesTableViewCell", for: indexPath) as? RecipesTableViewCell
        guard let recipeCell = cell else { return UITableViewCell() }
        recipeCell.configure(model: recipesListViewModel.recipeViewModel(at: (indexPath as NSIndexPath).row))
        return recipeCell
    }
}

