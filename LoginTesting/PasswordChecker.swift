//
//  PasswordChecker.swift
//  LoginTesting
//
//  Created by Jason bartley on 1/11/22.
//

import Foundation

struct PasswordChecker {
    func checkPassword(_ password: String?) throws -> String {
        guard let password = password else { throw signInError.invalidField }
        guard password.count > 8 else { throw signInError.passwordTooShort }
        guard password.count < 20 else { throw signInError.passwordTooLong }
        return password
    }
}
