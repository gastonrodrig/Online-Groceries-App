//
//  Brand.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 17/01/25.
//

import Foundation

struct BrandModel: Codable {
    var id: String
    var name: String
    var description: String
    
    // MARK: - Inicializador desde un diccionario
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.description = dict["description"] as? String ?? ""
    }
    
    // MARK: - Convertir a diccionario
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "description": description
        ]
    }
}
