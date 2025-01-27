//
//  CreateCartModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 25/01/25.
//

import Foundation

struct CreateCartModel: Codable {
    var productId: String
    var userId: String
    var quantity: Int
}
