//
//  ProductModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 17/01/25.
//

import Foundation

// MARK: - ProductModel
struct ProductModel: Codable {
    var id: String
    var name: String
    var price: Double
    var unit_name: String
    var unit_value: Int
    var nutrition_weight: String
    var detail: String
    var rating: Int
    var review_count: Int
    var is_best_seller: Bool
    
    var category: CategoryModel?
    var categoryId: String?
    var brand: BrandModel?
    var brandId: String?
    var multimedia: MultimediaModel?
    var multimediaId: String?
    var offer: ProductOfferModel?
    
    // MARK: - Inicializador desde un diccionario
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.price = dict["price"] as? Double ?? 0.0
        self.unit_name = dict["unit_name"] as? String ?? ""
        self.unit_value = dict["unit_value"] as? Int ?? 0
        self.nutrition_weight = dict["nutrition_weight"] as? String ?? ""
        self.detail = dict["detail"] as? String ?? ""
        self.rating = dict["rating"] as? Int ?? 0
        self.review_count = dict["review_count"] as? Int ?? 0
        self.is_best_seller = dict["is_best_seller"] as? Bool ?? false
        self.offer = dict["offer"].flatMap { ProductOfferModel(dict: $0 as? [String: Any] ?? [:]) }
        
        if let categoryDict = dict["category"] as? [String: Any] { self.category = CategoryModel(dict: categoryDict) }
        else { self.category = nil }
        self.categoryId = dict["categoryId"] as? String
        
        if let brandDict = dict["brand"] as? [String: Any] { self.brand = BrandModel(dict: brandDict) }
        else { self.brand = nil }
        self.brandId = dict["brandId"] as? String
        
        if let multimediaDict = dict["multimedia"] as? [String: Any] { self.multimedia = MultimediaModel(dict: multimediaDict) }
        else { self.multimedia = nil }
        self.multimediaId = dict["multimediaId"] as? String
    }
    
    // MARK: - Convertir a diccionario
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "id": id,
            "name": name,
            "price": price,
            "unit_name": unit_name,
            "unit_value": unit_value,
            "nutrition_weight": nutrition_weight,
            "detail": detail,
            "rating": rating,
            "review_count": review_count,
            "is_best_seller": is_best_seller
        ]
        
        // Brand
        if let brand = brand { dictionary["brand"] = brand.toDictionary() }
        if let brandId = brandId { dictionary["brandId"] = brandId }
        
        // Category
        if let category = category { dictionary["category"] = category.toDictionary() }
        if let categoryId = categoryId { dictionary["categoryId"] = categoryId }
        
        // Multimedia
        if let multimedia = multimedia { dictionary["multimedia"] = multimedia.toDictionary() }
        if let multimediaId = multimediaId { dictionary["multimediaId"] = multimediaId }
        
        // Agregar la oferta solo si existe
        if let offer = offer { dictionary["offer"] = offer.toDictionary() }
        
        return dictionary
    }
}
