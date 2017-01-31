//
//  User.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Foundation

public class User {

    var id: String
    var email: String
    var password: String?
    
    init(id: String, email: String, password: String? = nil) {
        self.id = id
        self.email = email
        self.password = password
    }
    
}
