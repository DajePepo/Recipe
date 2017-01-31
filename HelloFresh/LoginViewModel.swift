//
//  UserViewModel.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import CryptoSwift

class LoginViewModel: NSObject, UserProtocol {
    
    dynamic var isLoginButtonEnabled: Bool = false
    var email: String? {
        didSet {
            checkFields()
        }
    }
    var password: String? {
        didSet {
            checkFields()
        }
    }
    
    func checkFields() {
        guard   let email = email, !email.isEmpty, email.isValidEmail,
                let password = password, !password.isEmpty else {
                
                isLoginButtonEnabled = false
                return
        }
        isLoginButtonEnabled = true
    }

    func loginUser(success: (Bool) -> Void) {
        
        if let email = email, let password = password {
            let encryptedPassword = password.md5()
            UserDataManager.logIn(userEmail: email, userPassword: encryptedPassword) { result in
                if let userId = result {
                    let loggedUser = User(id: userId, email: email, password: password)
                    storeUserIntoUserDefaults(user: loggedUser)
                    success(true)
                }
                else {
                    success(false)
                }
            }
        }
    }
    
}
