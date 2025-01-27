//
//  CartModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 25/01/25.
//

import Foundation

struct CartModel: Codable {
    var id: String
    var product: ProductModel
    var user: UserModel
    var quantity: Int
    
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String ?? ""
        let productDict = dict["product"] as? [String: Any] ?? [:]
        self.product = ProductModel(dict: productDict)
        let userDict = dict["user"] as? [String: Any] ?? [:]
        self.user = UserModel(dict: userDict)
        self.quantity = dict["quantity"] as? Int ?? 0
    }
    
    func toDictionary() -> [String: Any] {
        [
            "id": id,
            "product": product.toDictionary(),
            "user": user.toDictionary(),
            "quantity": quantity
        ]
    }
}
