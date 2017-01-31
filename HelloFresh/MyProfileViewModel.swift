//
//  MyProfileViewModel.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 31/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

class MyProfileViewModel: UserProtocol {

    func isUserLogged() -> Bool {
        if let _ = getUserFromUserDefaults() { return true }
        else { return false }
    }
}
