//
//  FavoritesService.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 22/01/25.
//

import Foundation

class UserFavoritesService {
    static let shared = UserFavoritesService()
    private init() {}

    private let URL = APIConfig.baseURL + "/user-favorites"

    // Crear un favorito
    func createUserFavorite(favorite: CreateUserFavoriteModel, completion: @escaping (Result<Void, Error>) -> Void) {
        NetworkManager.shared.requestWithBody(url: URL, method: "POST", body: favorite) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Obtener todos los favoritos de un usuario
    func getUserFavoritesByUserId(userId: String, completion: @escaping (Result<[UserFavoriteModel], Error>) -> Void) {
        let newURL = "\(URL)/user/\(userId)"
        NetworkManager.shared.request(url: newURL, method: "GET") { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (result: Result<[UserFavoriteModel], Error>) in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Verificar si un producto es favorito
    func isFavorite(userId: String, productId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let newURL = "\(URL)/is-favorite/\(userId)/\(productId)"
        NetworkManager.shared.request(url: newURL, method: "GET") { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (result: Result<Bool, Error>) in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Eliminar un favorito por userId y productId
    func deleteUserFavoriteByUserAndProductId(userId: String, productId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let newURL = "\(URL)/user/\(userId)/product/\(productId)"
        NetworkManager.shared.request(url: newURL, method: "DELETE") { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
