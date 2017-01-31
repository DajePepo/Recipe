//
//  UserProtocol.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 31/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Foundation

protocol UserProtocol {
    func storeUserIntoUserDefaults(user: User)
    func getUserFromUserDefaults() -> User?
}

extension UserProtocol {
    
    func storeUserIntoUserDefaults(user: User) {
        
        var userDictionary = [[String: String]]()
        
        // Id
        let idDict = ["id": user.id]
        userDictionary.append(idDict)
        
        // Email
        let emailDict = ["email": user.email]
        userDictionary.append(emailDict)
        
        // Password
        if let password = user.password {
            let passwordDict = ["password": password]
            userDictionary.append(passwordDict)
        }
        
        let defaults = UserDefaults.standard
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: userDictionary), forKey: "isLogged")
        defaults.synchronize()
    }
    
    func getUserFromUserDefaults() -> User? {
        
        let defaults = UserDefaults.standard
        if let userData = defaults.data(forKey: "isLogged") {
            if let userDict = NSKeyedUnarchiver.unarchiveObject(with: userData) as? [String: String] {
                if let id = userDict["id"], let email = userDict["email"] {
                    let password = userDict["email"]
                    return User(id: id, email: email, password: password)
                }
            }
        }
        return nil
    }
}
