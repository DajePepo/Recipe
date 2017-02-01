//
//  UserViewModel.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import CryptoSwift

class LoginViewModel: NSObject {
    
    // Variables
    var userDataManager = UserDataManager()
    var defaultManager = UserDefaultsManager()
    dynamic var isLoginButtonEnabled: Bool = false
    var email: String? {
        didSet { checkFields() }
    }
    var password: String? {
        didSet { checkFields() }
    }
    
    // Check if email and passowrd are valid -> if so, set to true the "isLoginButtonEnabled" variable
    func checkFields() {
        guard   let email = email, !email.isEmpty,
                let password = password, !password.isEmpty else {
                
                isLoginButtonEnabled = false
                return
        }
        isLoginButtonEnabled = true
    }

    // Log in the user
    func loginUser(success: (Bool) -> Void) {
        
        if let email = email, let password = password {
            let encryptedPassword = password.md5()
            userDataManager.logIn(userEmail: email, userPassword: encryptedPassword) { (result, error) in
                if let userId = result {
                    let loggedUser = User(id: userId, email: email, password: password)
                    defaultManager.storeUserIntoUserDefaults(user: loggedUser)
                    success(true)
                }
                else { success(false) }
            }
        }
        else { success(false) }
    }
    
}
