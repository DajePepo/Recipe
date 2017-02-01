//
//  UserDataManager.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Foundation

public class UserDataManager {
    
    // Log the user in
    // Return the user id or nil and error message
    func logIn(userEmail: String, userPassword: String, completion: (_ userId: String?, _ error: String?) -> Void) {
        if Constants.logInWillFail { completion(nil, "Error logging the user") }
        else { completion("ID_000", nil) }
    }
}
