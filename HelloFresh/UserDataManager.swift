//
//  UserDataManager.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Foundation

public class UserDataManager {

    static func logIn(userEmail: String, userPassword: String, completion: (String?) -> Void) {
        completion("userId")
    }
    
    static func signUp(userEmail: String, userPassword: String, succes: (String) -> Void, fail: () -> Void) {
        
    }    
}
