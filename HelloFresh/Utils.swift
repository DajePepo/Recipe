//
//  Utils.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 30/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Foundation

class Utils {
    
    static func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }
    
    static func randomBetwwen(lower: UInt32, upper: UInt32) -> Int {
        return Int(arc4random_uniform(upper - lower) + lower)
    }

}
