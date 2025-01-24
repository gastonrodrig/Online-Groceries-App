//
//  MultimediaModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 17/01/25.
//

import Foundation

struct MultimediaModel: Codable {
    var id: String
    var nombre: String
    var url: String
    var tamanio: Int
    
    // MARK: - Inicializador desde un diccionario
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String ?? ""
        self.nombre = dict["nombre"] as? String ?? ""
        self.url = dict["url"] as? String ?? ""
        self.tamanio = dict["tamanio"] as? Int ?? 0
    }
    
    // MARK: - Convertir a diccionario
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "nombre": nombre,
            "url": url,
            "tamanio": tamanio
        ]
    }
}
