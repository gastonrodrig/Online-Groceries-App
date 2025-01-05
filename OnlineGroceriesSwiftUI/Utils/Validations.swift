//
//  Validations.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 4/01/25.
//

import Foundation

class Validation {
    // Validación de correo electrónico
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    // Validación de contraseña (mínimo 6 caracteres)
    static func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }

    // Validación de nombre de usuario (mínimo 3 caracteres)
    static func isValidUsername(_ username: String) -> Bool {
        return username.count >= 3
    }

    // Validación de número de teléfono (mínimo 9 dígitos)
    static func isValidMobile(_ mobile: String) -> Bool {
        return mobile.count >= 9
    }
}
