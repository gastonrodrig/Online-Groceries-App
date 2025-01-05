//
//  MainViewModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 30/12/24.
//

import SwiftUI
import FirebaseAuth

class AuthenticationViewModel: ObservableObject {
    static let shared = AuthenticationViewModel()
    
    // MARK: - Propiedades Observables
    @Published var txtUsername: String = ""
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var isShowPassword: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var isUserLogin: Bool = false
    @Published var userObj: UserModel = UserModel(dict: [:])

    // MARK: - Estados de Autenticación
    enum AuthState {
        case unauthenticated
        case authenticated(user: User)
        case loading
        case error(message: String)
    }

    @Published var authState: AuthState = .unauthenticated
    
    // MARK: - Iniciar Sesión con Email/Contraseña
    func serviceCallLogin() {
        let loginForm = LoginForm(email: txtEmail, password: txtPassword)

        // Validar campos usando el modelo
        if let validationMessage = loginForm.validationMessage {
            updateError(message: validationMessage)
            return
        }

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
    
    // MARK: - Registro de Usuario
    func serviceCallRegister() {
        let registerForm = RegisterForm(username: txtUsername, email: txtEmail, password: txtPassword)

        // Validar campos usando el modelo
        if let validationMessage = registerForm.validationMessage {
            updateError(message: validationMessage)
            return
        }

        authState = .loading

        FirebaseAuthService.shared.registerWithEmail(email: txtEmail, password: txtPassword) { [weak self] result in
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
    
    // MARK: - Google Login
    func serviceCallGoogleLogin() {
        FirebaseAuthService.shared.loginWithGoogle { [weak self] result in
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

    // MARK: - Facebook Login
    func serviceCallFacebookLogin() {
        FirebaseAuthService.shared.loginWithFacebook { [weak self] result in
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
        userObj = UserModel(uid: user.uid,
                            username: txtUsername,
                            name: user.displayName ?? "",
                            email: user.email ?? "",
                            mobile: "")
        print(userObj.toDictionary())
        isUserLogin = true
        authState = .authenticated(user: user)
        clearFields()
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
