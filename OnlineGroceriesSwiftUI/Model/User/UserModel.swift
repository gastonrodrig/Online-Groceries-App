//
//  UserModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 31/12/24.
//

import Foundation

struct UserModel: Codable {
    // MARK: - Propiedades
    var uid: String
    var username: String
    var name: String
    var email: String
    var mobile: String
    
    // MARK: - Inicializador personalizado para manejar valores predeterminados
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uid = try container.decodeIfPresent(String.self, forKey: .uid) ?? ""
        self.username = try container.decodeIfPresent(String.self, forKey: .username) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.mobile = try container.decodeIfPresent(String.self, forKey: .mobile) ?? ""
    }

    // MARK: - Inicializadores
    // Inicializador predeterminado con diccionario
    init(dict: [String: Any]) {
        self.uid = dict["uid"] as? String ?? ""
        self.username = dict["username"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
        self.mobile = dict["mobile"] as? String ?? ""
    }

    // Inicializador adicional (opcional, para inicialización manual)
    init(uid: String = "", username: String = "", name: String = "", email: String = "", mobile: String = "") {
        self.uid = uid
        self.username = username
        self.name = name
        self.email = email
        self.mobile = mobile
    }

    // MARK: - Métodos de Validación
    var validationMessage: String? {
        if !Validation.isValidUsername(username) {
            return "Username must be at least 3 characters."
        }
        if !Validation.isValidEmail(email) {
            return "Please enter a valid email address."
        }
        if !Validation.isValidMobile(mobile) {
            return "Mobile number must be at least 9 digits."
        }
        return nil
    }

    var isValid: Bool {
        return validationMessage == nil
    }

    // MARK: - Métodos de Conversión
    // Convertir a diccionario
    func toDictionary() -> [String: Any] {
        return [
            "uid": uid,
            "username": username,
            "name": name,
            "email": email,
            "mobile": mobile
        ]
    }
}
