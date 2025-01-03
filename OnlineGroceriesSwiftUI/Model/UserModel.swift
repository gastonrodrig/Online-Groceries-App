//
//  UserModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 31/12/24.
//

import Foundation

struct UserModel {
    let uid: String
    var username: String
    var name: String
    var email: String
    var mobile: String
    
    // Validación de correo electrónico
    var isValidEmail: Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    // Validación de número de teléfono (mínimo 9 dígitos)
    var isValidMobile: Bool {
        return mobile.count >= 9
    }

    // Validación de nombre (no vacío)
    var isValidName: Bool {
        return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    // Validación de nombre de usuario (mínimo 3 caracteres)
    var isValidUsername: Bool {
        return username.count >= 3
    }
    
    // Constructor con diccionario
    init(dict: [String: Any]) {
        self.uid = dict["uid"] as? String ?? ""
        self.username = dict["username"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
        self.mobile = dict["mobile"] as? String ?? ""
    }
}
