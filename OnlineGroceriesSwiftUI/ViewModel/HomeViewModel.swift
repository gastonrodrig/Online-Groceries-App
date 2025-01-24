//
//  HomeViewModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 11/01/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    static let shared = HomeViewModel()
    
    @Published var selectTab: Int = 0
    @Published var txtSearch: String = ""
    
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var offerArr: [ProductModel] = []
    @Published var bestArr: [ProductModel] = []
    @Published var catArr: [CategoryModel] = []
    
    init() {
        self.fetchProductsWithOffer()
        self.fetchBestProducts()
        self.fetchCategories()
    }
 
    // MARK: - Obtención de Productos con Oferta
    func fetchProductsWithOffer() {
        ProductService.shared.getProductsWithOffer { result in
            print(result)
            switch result {
            case .success(let fetchedProducts):
                DispatchQueue.main.async {
                    self.offerArr = fetchedProducts
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: - Obtención de Mejores Productos
    func fetchBestProducts() {
        ProductService.shared.getBestSellers { result in
            switch result {
            case .success(let fetchedProducts):
                DispatchQueue.main.async {
                    self.bestArr = fetchedProducts
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: - Obtención de las Categorias
    func fetchCategories() {
        CategoryService.shared.getCategories { result in
            switch result {
            case .success(let fetchedCategories):
                DispatchQueue.main.async {
                    self.catArr = fetchedCategories
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
}
