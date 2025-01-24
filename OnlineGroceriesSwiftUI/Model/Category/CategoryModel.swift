//
//  Category.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 17/01/25.
//

import Foundation

struct CategoryModel: Codable {
    var id: String
    var name: String
    var description: String
    var multimedia: MultimediaModel?
    var multimediaId: String?
    
    // MARK: - Inicializador desde un diccionario
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.description = dict["description"] as? String ?? ""
        
        // Inicializar multimedia como un objeto si está presente
        if let multimediaDict = dict["multimedia"] as? [String: Any] {
            self.multimedia = MultimediaModel(dict: multimediaDict)
        } else {
            self.multimedia = nil
        }
        
        // Inicializar multimediaId si está presente
        self.multimediaId = dict["multimediaId"] as? String
    }
    
    // MARK: - Convertir a diccionario
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "id": id,
            "name": name,
            "description": description
        ]
        
        if let multimedia = multimedia {
            dictionary["multimedia"] = multimedia.toDictionary()
        }
        
        if let multimediaId = multimediaId {
            dictionary["multimediaId"] = multimediaId
        }
        
        return dictionary
    }
}
