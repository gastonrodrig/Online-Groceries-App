//
//  NutritionModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 21/01/25.
//

import Foundation

struct NutritionModel: Codable {
    var id: String
    var nutrition_name: String
    var nutrition_value: String
    
    // MARK: - Inicializador desde un diccionario
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String ?? ""
        self.nutrition_name = dict["nutrition_name"] as? String ?? ""
        self.nutrition_value = dict["nutrition_value"] as? String ?? ""
    }
    
    // MARK: - Convertir a diccionario
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "nutrition_name": nutrition_name,
            "nutrition_value": nutrition_value
        ]
    }
}
