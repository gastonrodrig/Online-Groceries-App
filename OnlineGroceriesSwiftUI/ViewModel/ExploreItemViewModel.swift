//
//  ExploreItemViewModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 25/01/25.
//

import Foundation

class ExploreItemViewModel: ObservableObject {    
    @Published var cObj: CategoryModel = CategoryModel(dict: [:])
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var listArr: [ProductModel] = []
    
    init(catObj: CategoryModel) {
        self.cObj = catObj
        self.fetchProductsByCategory()
    }
    
    // MARK: - Obtener nutrición
    func fetchProductsByCategory() {
        ProductService.shared.getProductsByCategoryId(categoryId: cObj.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let productData):
                    self?.listArr = productData
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
