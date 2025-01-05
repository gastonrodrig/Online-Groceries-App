//
//  Login.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 4/01/25.
//

import Foundation

struct LoginForm {
    var email: String
    var password: String

    // Mensaje de validación
    var validationMessage: String? {
        if !Validation.isValidEmail(email) {
            return "Please enter a valid email address."
        }
        if password.isEmpty {
            return "Password cannot be empty."
        }
        return nil
    }

    // Validez general
    var isValid: Bool {
        return validationMessage == nil
    }
}
