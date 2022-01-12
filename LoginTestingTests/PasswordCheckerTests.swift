//
//  PasswordCheckerTests.swift
//  LoginTestingTests
//
//  Created by Jason bartley on 1/11/22.
//

import XCTest
@testable import LoginTesting

class PasswordCheckerTests: XCTestCase {

    var passwordChecker: PasswordChecker!
    
    override func setUp() {
        passwordChecker = PasswordChecker()
    }
    
    override func tearDown() {
        passwordChecker = nil
    }
    
    func test_is_valid_password() throws {
        XCTAssertNoThrow(try passwordChecker.checkPassword("password123"))
    }
    
    
    func password_is_nil() throws {
        let expectedError = signInError.invalidField
        var error: signInError?
        
        XCTAssertThrowsError( try passwordChecker.checkPassword(nil)) {
            thrownError in
            
            error = thrownError as? signInError
        }
        
        XCTAssertEqual(error , expectedError)
    }
    

    func password_is_too_short() throws {
        let expectedError = signInError.passwordTooShort
        var error: signInError?
        
        XCTAssertThrowsError(try passwordChecker.checkPassword("a")) {
            thrownError in
            error = thrownError as? signInError
        }
        
        XCTAssertEqual(error, expectedError)
    }
    
    
    func password_is_too_long() throws {
        let expectedError = signInError.passwordTooLong
        var error: signInError?
        
        XCTAssertThrowsError(try passwordChecker.checkPassword("aaaaaaaaaabbbbbbbbbbbbbbcccccccccccccdddddddddddd")) {
            thrownError in
            error = thrownError as? signInError
        }
        
        XCTAssertEqual(error, expectedError)
    }

}
