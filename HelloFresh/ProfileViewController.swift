//
//  ProfileViewController.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 31/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // Variables
    var myProfileViewModel = MyProfileViewModel()
    
    // Outlets
    @IBOutlet weak var unloggedViewContainer: UIView!
    
    // Life cycles methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the unlogged view from the sub view controllers list
        for viewController in self.childViewControllers {
            if let unloggedVC = viewController as? UnloggedViewController {

                // And set the delegate
                unloggedVC.delegate = self
            }
        }
        
        // Check if user is logged -> If no show the unlogged view
        if !myProfileViewModel.defaultsManager.isUserLogged() {
            showUnloggedView()
        }
    }
    
    // Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let loginVC = segue.destination as? LoginViewController {
            loginVC.delegate = self
        }
    }
    
    // Show and hide unlogged view
    func showUnloggedView() {
        unloggedViewContainer.isHidden = false
    }
    
    func hideUnloggedView() {
        unloggedViewContainer.isHidden = true
    }

}


// MARK: - Unlogged delegate

extension ProfileViewController: UnloggedDelegate {
    
    func goToLoginViewController() {
        self.performSegue(withIdentifier: "fromMyProfileToLogin", sender: nil)
    }
}


// MARK: - Login delegate

extension ProfileViewController: LoginDelegate {
    
    func userLoggedSuccessfully() {
        hideUnloggedView()
    }
}
