//
//  ProductDetailViewModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 20/01/25.
//

import SwiftUI

class ProductDetailViewModel: ObservableObject {
    @Published var pObj: ProductModel = ProductModel(dict: [:])
    @Published var userObj: UserModel = UserModel(dict: [:])
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var nutritionArr: [NutritionModel] = []
    @Published var multimedia: [MultimediaModel] = []
    
    @Published var isFav: Bool = false
    @Published var isShowDetail: Bool = false
    @Published var isShowNutrition: Bool = false
    @Published var qty: Int = 1
    
    private var userId = ""
    
    func showDetail(){
       isShowDetail = !isShowDetail
    }
    
    func showNutrition(){
       isShowNutrition = !isShowNutrition
    }
    
    func addSubQTY(isAdd: Bool = true) {
       if(isAdd) {
           qty += 1
           if(qty > 99) {
               qty = 99
           }
       } else {
           qty -= 1
           if(qty < 1) {
               qty = 1
           }
       }
    }
    
    init(prodObj: ProductModel) {
        userObj = AuthenticationViewModel.shared.userObj
        self.userId = userObj.uid
        self.pObj = prodObj
        fetchNutrition()
        checkIfFavorite()
    }
    
    // MARK: - Obtener nutrición
    func fetchNutrition() {
        ProductService.shared.getNutritionByProductId(productID: pObj.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let nutritionData):
                    self?.nutritionArr = nutritionData
                case .failure(let error):
                    self?.showErrorMessage(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Verificar si es favorito
    func checkIfFavorite() {
        UserFavoritesService.shared.isFavorite(userId: userId, productId: pObj.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let isFavVal):
                    self?.isFav = isFavVal
                case .failure(let error):
                    self?.showErrorMessage(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Alternar favoritos
    func toggleFavorite() {
        if isFav {
            removeFromFavorites()
        } else {
            addToFavorites()
        }
    }
    
    // MARK: - Agregar a favoritos
    func addToFavorites() {
        let favModel = CreateUserFavoriteModel(productId: pObj.id, userId: userId)
        UserFavoritesService.shared.createUserFavorite(favorite: favModel) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isFav = true
                case .failure(let error):
                    self?.showErrorMessage(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Quitar de favoritos
    func removeFromFavorites() {
        UserFavoritesService.shared.deleteUserFavoriteByUserAndProductId(userId: userId, productId: pObj.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isFav = false
                    print("Toggling favorite. Current state: \(String(describing: self?.isFav))")
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
