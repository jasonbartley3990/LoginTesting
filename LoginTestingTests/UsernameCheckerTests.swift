//
//  UsernameCheckerTests.swift
//  LoginTestingTests
//
//  Created by Jason bartley on 1/11/22.
//

import XCTest
@testable import LoginTesting

class UsernameCheckerTests: XCTestCase {

    var usernameChecker: UsernameChecker!
    
    override func setUp() {
        usernameChecker = UsernameChecker()
    }
    
    override func tearDown() {
        usernameChecker = nil
    }
    
    
    func test_is_valid_username() throws {
        XCTAssertNoThrow(try usernameChecker.checkUsername("billy"))
    }
    
    
    func username_is_nil() throws {
        let expectedError = signInError.invalidField
        var error: signInError?
        
        XCTAssertThrowsError( try usernameChecker.checkUsername(nil)) {
            thrownError in
            
            error = thrownError as? signInError
        }
        
        XCTAssertEqual(error , expectedError)
    }
    

    func username_is_too_short() throws {
        let expectedError = signInError.usernameTooShort
        var error: signInError?
        
        XCTAssertThrowsError(try usernameChecker.checkUsername("a")) {
            thrownError in
            error = thrownError as? signInError
        }
        
        XCTAssertEqual(error, expectedError)
    }
    
    
    func username_is_too_long() throws {
        let expectedError = signInError.usernameTooLong
        var error: signInError?
        
        XCTAssertThrowsError(try usernameChecker.checkUsername("aaaaaaaaaabbbbbbbbbbbbbbcccccccccccccdddddddddddd")) {
            thrownError in
            error = thrownError as? signInError
        }
        
        XCTAssertEqual(error, expectedError)
    }
    
}
