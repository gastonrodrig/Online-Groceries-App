//
//  CategoryService.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 19/01/25.
//

import Foundation

class CategoryService {
    static let shared = CategoryService()
    private init() {}

    private let URL = APIConfig.baseURL + "/category"

    // Obtener todas las categorias (GET /category)
    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        NetworkManager.shared.request(url: URL, method: "GET") { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.decode(data) { (result: Result<[CategoryModel], Error>) in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
