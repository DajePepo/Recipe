//
//  StringExtension.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 31/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        get {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: self)
        }
    }
}
