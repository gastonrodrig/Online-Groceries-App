//
//  ProductReviewModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 18/01/25.
//

import Foundation

struct ProductReviewModel: Codable {
    var id: String
    var rating: Int
    var comment: String
    var createdAt: String? // Opcional
    var updatedAt: String? // Opcional
    var product: ProductModel
    var user: UserModel
    
    // MARK: - Convertir a diccionario
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "id": id,
            "rating": rating,
            "comment": comment,
            "product": product.toDictionary(),
            "user": user.toDictionary()
        ]

        if let createdAt = createdAt {
            dictionary["createdAt"] = createdAt
        }
        
        if let updatedAt = updatedAt {
            dictionary["updatedAt"] = updatedAt
        }

        return dictionary
    }
}
