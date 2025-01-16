//
//  UserService.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 15/01/25.
//

import Foundation

class UserService {
    static let shared = UserService()
    private init() {}

    private let userURL = APIConfig.baseURL + "/user"

    // Crear usuario sin proveedor (POST /user/no-provider)
    func createUserNoProvider(user: CreateUserNoProviderModel, completion: @escaping (Result<CreateUserNoProviderModel, Error>) -> Void) {
        let url = "\(userURL)/no-provider"
        NetworkManager.shared.requestWithBody(url: url, method: "POST", body: user) { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (result: Result<CreateUserNoProviderModel, Error>) in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Crear usuario con proveedor (POST /user/provider)
    func createUserWithProvider(user: CreateUserWithProviderModel, completion: @escaping (Result<CreateUserWithProviderModel, Error>) -> Void) {
        let url = "\(userURL)/provider"
        NetworkManager.shared.requestWithBody(url: url, method: "POST", body: user) { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (result: Result<CreateUserWithProviderModel, Error>) in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Buscar usuario por Email (GET)
    func getUserByEmail(email: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        let emailEncoded = email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? email
        let url = "\(userURL)/email?email=\(emailEncoded)"

        NetworkManager.shared.request(url: url, method: "GET") { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (result: Result<UserModel, Error>) in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Obtener usuario por ID (GET)
    func getUserByID(userID: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        NetworkManager.shared.request(url: "\(userURL)/\(userID)", method: "GET") { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (result: Result<UserModel, Error>) in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Actualizar usuario (PATCH)
    func updateUser(userID: String, user: UpdateUserModel, completion: @escaping (Result<UpdateUserModel, Error>) -> Void) {
        let url = "\(userURL)/\(userID)"
        NetworkManager.shared.requestWithBody(url: url, method: "PATCH", body: user) { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (result: Result<UpdateUserModel, Error>) in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Eliminar usuario (DELETE)
    func deleteUser(userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "\(userURL)/\(userID)"
        NetworkManager.shared.request(url: url, method: "DELETE") { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
