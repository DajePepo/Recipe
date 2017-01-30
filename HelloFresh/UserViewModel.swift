//
//  UserViewModel.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 28/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

class UserViewModel {
    
    var id: String
    var email: String
    var password: String?
    
    init(id: String, email: String) {
        self.id = id
        self.email = email
    }
}
