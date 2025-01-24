//
//  Offer.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 18/01/25.
//

import Foundation

struct ProductOfferModel: Codable {
    var price: Double
    var start_date: String
    var end_date: String
    
    // MARK: - Inicializador desde un diccionario
    init(dict: [String: Any]) {
        self.price = dict["price"] as? Double ?? 0.0
        self.start_date = dict["start_date"] as? String ?? ""
        self.end_date = dict["end_date"] as? String ?? ""
    }
    
    // MARK: - Convertir a diccionario
    func toDictionary() -> [String: Any] {
        return [
            "price": price,
            "start_date": start_date,
            "end_date": end_date
        ]
    }
}
