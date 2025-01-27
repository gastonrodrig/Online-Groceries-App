//
//  CartService.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 25/01/25.
//

import Foundation

class CartService {
    static let shared = CartService()
    private init() {}
    
    private let baseURL = APIConfig.baseURL + "/cart"
    
    // Obtener todos los ítems del carrito (GET /cart)
    func getAllCartItems(completion: @escaping (Result<[CartModel], Error>) -> Void) {
        NetworkManager.shared.request(url: baseURL, method: "GET") { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (decodeResult: Result<[CartModel], Error>) in
                    completion(decodeResult)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Obtener los ítems del carrito de un usuario (GET /cart/user/{userId})
    func getCartItemsByUserId(userId: String, completion: @escaping (Result<[CartModel], Error>) -> Void) {
        let newURL = "\(baseURL)/user/\(userId)"
        NetworkManager.shared.request(url: newURL, method: "GET") { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (decodeResult: Result<[CartModel], Error>) in
                    completion(decodeResult)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Verificar si un producto está en el carrito de un usuario (GET /cart/is-in-cart/:userId/:productId)
    func isInCart(userId: String, productId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let newURL = "\(baseURL)/is-in-cart/\(userId)/\(productId)"
        NetworkManager.shared.request(url: newURL, method: "GET") { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (decodeResult: Result<Bool, Error>) in
                    completion(decodeResult)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Crear un nuevo ítem en el carrito (POST /cart)
    func createCartItem(cartItem: CreateCartModel, completion: @escaping (Result<CreateCartModel, Error>) -> Void) {
        NetworkManager.shared.requestWithBody(url: baseURL, method: "POST", body: cartItem) { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (decodeResult: Result<CreateCartModel, Error>) in
                    completion(decodeResult)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Incrementar la cantidad (PATCH /cart/increase/{userId}/{productId})
    func increaseCartQuantity(userId: String, productId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let newURL = "\(baseURL)/increase/\(userId)/\(productId)"
        NetworkManager.shared.request(url: newURL, method: "PATCH") { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Disminuir la cantidad (PATCH /cart/decrease/{userId}/{productId})
    func decreaseCartQuantity(userId: String, productId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let newURL = "\(baseURL)/decrease/\(userId)/\(productId)"
        NetworkManager.shared.request(url: newURL, method: "PATCH") { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Eliminar un ítem del carrito (DELETE /cart/user/{userId}/product/{productId})
    func deleteCartItemByUserAndProductId(userId: String, productId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let newURL = "\(baseURL)/user/\(userId)/product/\(productId)"
        NetworkManager.shared.request(url: newURL, method: "DELETE") { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Agregar múltiple cantidad de cierto producto al carrito (PATCH /cart/add-multiple/:userId/:productId)
    func addMultipleQuantity(cartItem: CartAddMultipleModel, userId: String, productId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let newURL = "\(baseURL)/add-multiple/\(userId)/\(productId)"
        NetworkManager.shared.requestWithBody(url: newURL, method: "PATCH", body: cartItem) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
