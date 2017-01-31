//
//  UnloggedViewController.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 31/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

protocol UnloggedDelegate {
    func goToLoginViewController()
}

class UnloggedViewController: UIViewController {
    
    var delegate: UnloggedDelegate?

    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.borderWidth = 1
            loginButton.layer.borderColor = UIColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1).cgColor
        }
    }
    
    @IBAction func didClickOnLoginButton(_ sender: Any) {        
        delegate?.goToLoginViewController()
    }
    
    
}
