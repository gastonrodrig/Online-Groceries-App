//
//  FavoriteViewModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 23/01/25.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    static let shared = FavoriteViewModel()
    
    @Published var userObj: UserModel = UserModel(dict: [:])
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var favListArr: [UserFavoriteModel] = []
    
    private var userId = "pNDMUdXYgaFzQvCt3093"
    
    init() {
        userObj = AuthenticationViewModel.shared.userObj
        self.userId = userObj.uid
        self.fetchFavoritesByUser()
    }
    
    // MARK: - Obtener favoritos según usuario
    func fetchFavoritesByUser() {
        UserFavoritesService.shared.getUserFavoritesByUserId(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                print(result)
                switch result {
                case .success(let favListData):
                    self?.favListArr = favListData
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
