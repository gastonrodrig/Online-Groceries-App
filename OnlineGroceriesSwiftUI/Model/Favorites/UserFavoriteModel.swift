//
//  UserFavoriteModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 18/01/25.
//

import Foundation

struct UserFavoriteModel: Codable {
    var id: String
    var product: ProductModel
    var user: UserModel
    
    // MARK: - Convertir a diccionario
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "product": product.toDictionary(),
            "user": user.toDictionary()
        ]
    }
}
