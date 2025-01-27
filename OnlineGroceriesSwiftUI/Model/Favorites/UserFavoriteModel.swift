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
    
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String ?? ""
        self.product = ProductModel(dict: dict["product"] as? [String: Any] ?? [:])
        self.user = UserModel(dict: dict["user"] as? [String: Any] ?? [:])
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "product": product.toDictionary(),
            "user": user.toDictionary()
        ]
    }
}
