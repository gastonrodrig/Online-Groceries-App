//
//  ProductService.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 17/01/25.
//

import Foundation

class ProductService {
    static let shared = ProductService()
    private init() {}

    private let URL = APIConfig.baseURL + "/product"

    // Obtener todos los productos (GET /product)
    func getProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        NetworkManager.shared.request(url: URL, method: "GET") { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (result: Result<[ProductModel], Error>) in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Obtener todos los productos con oferta (GET /product/with-offer)
    func getProductsWithOffer(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        let newURL = "\(URL)/with-offer"
        NetworkManager.shared.request(url: newURL, method: "GET") { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (result: Result<[ProductModel], Error>) in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Obtener todos los productos marcados como "best-sellers" (GET /product/best-sellers)
    func getBestSellers(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        let newURL = "\(URL)/best-sellers"
        NetworkManager.shared.request(url: newURL, method: "GET") { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (result: Result<[ProductModel], Error>) in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Obtener un producto por su ID (GET /product/{id})
    func getProductById(productID: String, completion: @escaping (Result<ProductModel, Error>) -> Void) {
        let newURL = "\(URL)/\(productID)"
        NetworkManager.shared.request(url: newURL, method: "GET") { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (result: Result<ProductModel, Error>) in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Obtener información nutricional por ID de producto (GET /product/{productId}/nutrition)
    func getNutritionByProductId(productID: String, completion: @escaping (Result<[NutritionModel], Error>) -> Void) {
        let newURL = "\(URL)/\(productID)/nutrition"
        NetworkManager.shared.request(url: newURL, method: "GET") { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (result: Result<[NutritionModel], Error>) in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
