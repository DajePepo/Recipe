//
//  LoginViewController.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 31/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

protocol LoginDelegate {
    func userLoggedSuccessfully()
}

class LoginViewController: UIViewController {
    
    var loginViewModel = LoginViewModel()
    var delegate: LoginDelegate?
    
    // Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set a gesture to hide the keyboard with a tap
        hideKeyboardWhenTappedAround()
        
        // Bind UI elements with view model attributes
        emailTextField.addTarget(self, action: #selector(updateEmail(textField:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(updatePassword(textField:)), for: .editingChanged)
        addObserver(self, forKeyPath: #keyPath(loginViewModel.isLoginButtonEnabled), options: .new, context: nil)
    }
    
    
    // Actions
    @IBAction func didClickOnCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didClickOnLoginButton(_ sender: Any) {
        loginViewModel.loginUser { logged in
            if logged {
                delegate?.userLoggedSuccessfully()
                self.dismiss(animated: true, completion: nil)
                return
            }
            else {
                // show message error
            }
        }
    }
    
    // Textfields binding
    func updateEmail(textField: UITextField) {
        loginViewModel.email = textField.text
    }
    
    func updatePassword(textField: UITextField) {
        loginViewModel.password = textField.text
    }
    
    // Login button binding
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(loginViewModel.isLoginButtonEnabled) {
            loginButton.isEnabled = loginViewModel.isLoginButtonEnabled
        }
    }

    deinit {
        removeObserver(self, forKeyPath: #keyPath(loginViewModel.isLoginButtonEnabled))
    }

}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        return
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}

