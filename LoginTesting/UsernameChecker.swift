//
//  UsernameChecker.swift
//  LoginTesting
//
//  Created by Jason bartley on 1/11/22.
//

import Foundation

struct UsernameChecker {
    func checkUsername(_ username: String?) throws -> String {
        guard let user = username else { throw signInError.invalidField }
        guard user.count > 3 else { throw signInError.usernameTooShort }
        guard user.count < 20 else { throw signInError.usernameTooLong }
        return user
    }
}


