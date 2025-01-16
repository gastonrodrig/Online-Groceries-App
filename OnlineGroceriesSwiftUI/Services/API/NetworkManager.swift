//
//  NetworkManager.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 15/01/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    // MARK: - Solicitudes sin cuerpo
    func request(
        url: String,
        method: String,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])))
            }
        }.resume()
    }

    // MARK: - Solicitudes con cuerpo
    func requestWithBody<T: Codable>(
        url: String,
        method: String,
        body: T,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])))
            }
        }.resume()
    }

    // MARK: - Decodificar Datos
    func decode<T: Codable>(_ data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
}
