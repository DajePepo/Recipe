//
//  User.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

public class User {

    var userName: String
    var email: String
    var password: String?
    var token: String
    
    init(userName: String, email: String, token: String) {
        self.userName = userName
        self.email = email
        self.token = token
    }

}
