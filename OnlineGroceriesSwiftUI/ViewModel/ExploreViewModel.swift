//
//  ExploreViewModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 25/01/25.
//

import Foundation

class ExploreViewModel: ObservableObject {
    static let shared = ExploreViewModel()
    
    @Published var txtSearch: String = ""
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var listArr: [CategoryModel] = []
    
    init() {
        self.fetchCategories()
    }
    
    // MARK: - Obtener nutrición
    func fetchCategories() {
        CategoryService.shared.getCategories { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categoryData):
                    self?.listArr = categoryData
                case .failure(let error):
                    self?.showErrorMessage(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Manejo de errores
    func showErrorMessage(_ msg: String) {
        errorMessage = msg
        showError = true
    }
}
