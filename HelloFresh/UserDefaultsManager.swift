//
//  UserDefaultsManager.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 01/02/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//


import Foundation

class UserDefaultsManager {
    
    func isUserLogged() -> Bool {
        if Constants.userWillBeLogged { return true }
        if let _ = getUserFromUserDefaults() {
            return true
        }
        else { return false }
    }
    
    func getLoggedUserId() -> String? {
        if Constants.userWillBeLogged, let userId = Constants.fakeUserId { return userId }
        guard let user = getUserFromUserDefaults() else { return nil }
        return user.id
    }
    
    func storeUserIntoUserDefaults(user: User) {
        
        var userDictionary = [String: String]()
        
        // Id
        userDictionary["id"] = user.id
        
        // Email
        userDictionary["email"] = user.email
        
        // Password
        if let password = user.password {
            userDictionary["password"] = password
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
