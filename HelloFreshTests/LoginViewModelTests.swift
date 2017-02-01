//
//  LoginViewModelTests.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 01/02/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import XCTest
@testable import HelloFresh

class LoginViewModelTests: XCTestCase {
    
    var loginViewModel: LoginViewModel!
    let defaults = UserDefaults.standard
    
    override func setUp() {
        super.setUp()
        loginViewModel = LoginViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUserInfoSavedAfterLogin() {
        
        loginViewModel.email = "name.surname@email.com"
        loginViewModel.password = "123456"
        defaults.set(nil, forKey: "isLogged")
        
        var expectationWithDescription: XCTestExpectation? = expectation(description: "expectation")
        loginViewModel.loginUser() { _ in
            expectationWithDescription?.fulfill()
            expectationWithDescription = nil
        }
        waitForExpectations(timeout: 5) { [unowned self] _ in
            let userData = self.defaults.data(forKey: "isLogged")
            XCTAssertNotNil(userData, "User has not been saved correctly")
            if userData != nil, let userDict = NSKeyedUnarchiver.unarchiveObject(with: userData!) as? [String: String] {
                XCTAssertEqual(userDict["email"], self.loginViewModel.email, "User email has not been saved correctly")
                XCTAssertEqual(userDict["password"], self.loginViewModel.password, "User password has not been saved correctly")
            }
        }
    }

}
