//
//  Register.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 4/01/25.
//

import Foundation

struct RegisterForm {
    var username: String
    var email: String
    var password: String

    var validationMessage: String? {
        if !Validation.isValidUsername(username) {
            return "Username must be at least 3 characters."
        }
        if !Validation.isValidEmail(email) {
            return "Please enter a valid email address."
        }
        if !Validation.isValidPassword(password) {
            return "Password must be at least 6 characters."
        }
        return nil
    }

    var isValid: Bool {
        return validationMessage == nil
    }
}
