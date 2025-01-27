//
//  CartViewModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 25/01/25.
//

import SwiftUI

class CartViewModel: ObservableObject {
    static let shared = CartViewModel()
    
    @Published var userObj: UserModel = UserModel(dict: [:])
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var isLoading: Bool = false
    
    @Published var cartItems: [CartModel] = []
    
    private var qty = 0
    private var userId = "pNDMUdXYgaFzQvCt3093" // Ajusta según tu lógica de usuario
    
    init() {
//        userObj = AuthenticationViewModel.shared.userObj
//        self.userId = userObj.uid
        fetchCartItemsByUser()
    }
    
    func fetchCartItemsByUser(completion: (() -> Void)? = nil) {
        isLoading = true
        CartService.shared.getCartItemsByUserId(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                if case .success(let items) = result {
                    self?.cartItems = items
                } else if case .failure(let error) = result {
                    self?.showErrorMessage(error.localizedDescription)
                }
                // Llama al closure si se proporcionó
                completion?()
            }
        }
    }
    
    func addToCart(product: ProductModel, qty: Int) {
        CartService.shared.isInCart(userId: userId, productId: product.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let inCart):
                    if inCart {
                        self?.addMultipleQuantity(for: product, quantity: qty)
                    } else {
                        self?.createCartItem(product: product, quantity: qty)
                    }
                case .failure(let error):
                    self?.showErrorMessage(error.localizedDescription)
                }
            }
        }
    }
    
    func addMultipleQuantity(for product: ProductModel, quantity: Int) {
        let cartAddMultipleModel = CartAddMultipleModel(quantity: quantity)
        CartService.shared.addMultipleQuantity(cartItem: cartAddMultipleModel, userId: userId, productId: product.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.fetchCartItemsByUser()
                case .failure(let error):
                    self?.showErrorMessage(error.localizedDescription)
                }
            }
        }
    }
    
    func createCartItem(product: ProductModel, quantity: Int) {
        let newItem = CreateCartModel(productId: product.id, userId: userId, quantity: quantity)
        CartService.shared.createCartItem(cartItem: newItem) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.fetchCartItemsByUser()
                case .failure(let error):
                    self?.showErrorMessage(error.localizedDescription)
                }
            }
        }
    }
    
    func increase_1_Quantity(for product: ProductModel) {
        CartService.shared.increaseCartQuantity(userId: userId, productId: product.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.fetchCartItemsByUser()
                case .failure(let error):
                    self?.showErrorMessage(error.localizedDescription)
                }
            }
        }
    }
    
    func decrease_1_Quantity(for product: ProductModel) {
        CartService.shared.decreaseCartQuantity(userId: userId, productId: product.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.fetchCartItemsByUser()
                case .failure(let error):
                    self?.showErrorMessage(error.localizedDescription)
                }
            }
        }
    }
    
    func removeItem(for product: ProductModel) {
        CartService.shared.deleteCartItemByUserAndProductId(userId: userId, productId: product.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.fetchCartItemsByUser()
                case .failure(let error):
                    self?.showErrorMessage(error.localizedDescription)
                }
            }
        }
    }
    
    func decreaseQuantityOrRemove(for product: ProductModel) {
        if let cartItem = cartItems.first(where: { $0.product.id == product.id }) {
            if cartItem.quantity > 1 {
                decrease_1_Quantity(for: product)
            } else {
                removeItem(for: product)
            }
        } else {
            showErrorMessage("El producto no existe en el carrito.")
        }
    }
    
    func showErrorMessage(_ msg: String) {
        errorMessage = msg
        showError = true
    }
}
