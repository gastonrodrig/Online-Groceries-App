//
//  MainViewModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 30/12/24.
//

import SwiftUI
import FirebaseAuth

class MainViewModel: ObservableObject {
    static let shared = MainViewModel()

    // MARK: - Propiedades Observables
    @Published var txtUsername: String = ""
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var isShowPassword: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var isUserLogin: Bool = false
    @Published var userObj: UserModel = UserModel(dict: [:])
    @Published var authState: AuthState = .unauthenticated

    // MARK: - Estados de Autenticación
    enum AuthState {
        case unauthenticated
        case authenticated(user: User)
        case loading
        case error(message: String)
    }

    // MARK: - Validaciones
    private func validateFields() -> Bool {
        if txtUsername.isEmpty {
            updateError(message: "Please enter your username.")
            return false
        }

        if txtEmail.isEmpty {
            updateError(message: "Please enter your email.")
            return false
        }

        if txtPassword.isEmpty {
            updateError(message: "Please enter your password.")
            return false
        }

        // Validar email
        let tempUser = UserModel(dict: [
            "username": txtUsername,
            "email": txtEmail,
            "password": txtPassword,
            "mobile": ""
        ])

        if !tempUser.isValidEmail {
            updateError(message: "Please enter a valid email address.")
            return false
        }

        // Validar nombre de usuario
        if !tempUser.isValidUsername {
            updateError(message: "Username must be at least 3 characters.")
            return false
        }

        return true
    }

    // MARK: - Iniciar Sesión con Email/Contraseña
    func serviceCallLogin() {
        guard validateFields() else { return }

        authState = .loading

        FirebaseAuthService.shared.loginWithEmail(email: txtEmail, password: txtPassword) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let authResult):
                    self?.setUserData(user: authResult)
                case .failure(let error):
                    self?.updateError(message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Google Login
       func serviceCallGoogleLogin() {
           FirebaseAuthService.shared.loginWithGoogle { result in
               switch result {
               case .success(let user):
                   print("User logged in: \(user.email ?? "Unknown email")")
               case .failure(let error):
                   print("Login failed with error: \(error.localizedDescription)")
               }
           }
       }

       // MARK: - Facebook Login
       func serviceCallFacebookLogin(presentingViewController: UIViewController) {
           FirebaseAuthService.shared.loginWithFacebook(presentingViewController: presentingViewController) { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let user):
                       self?.setUserData(user: user)
                   case .failure(let error):
                       self?.updateError(message: error.localizedDescription)
                   }
               }
           }
       }

    // MARK: - Guardar Datos del Usuario
    func setUserData(user: User) {
        userObj = UserModel(dict: [
            "uid": user.uid,
            "username": txtUsername,
            "name": user.displayName ?? "",
            "email": user.email ?? "",
            "mobile": ""
        ])
        print(userObj)
        isUserLogin = true

        // Limpiar campos
        txtUsername = ""
        txtEmail = ""
        txtPassword = ""
        isShowPassword = false
    }

    // MARK: - Manejo de Errores
    private func updateError(message: String) {
        errorMessage = message
        showError = true
        authState = .error(message: message)
    }

    // MARK: - Limpiar Campos
    private func clearFields() {
        txtUsername = ""
        txtEmail = ""
        txtPassword = ""
        isShowPassword = false
    }
}
