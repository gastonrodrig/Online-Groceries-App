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
    @Published var showSuccess = false
    @Published var successMessage = ""
    @Published var isUserLogin: Bool = false
    @Published var userObj: UserModel = UserModel(dict: [:])

    // MARK: - Estados de Autenticación
    enum AuthState {
        case unauthenticated
        case authenticated(user: User)
        case loading
        case error(message: String)
        case success(message: String)
    }

    @Published var authState: AuthState = .unauthenticated
    
    // MARK: - Autenticación Genérica
    private func authenticate(action: @escaping (@escaping (Result<User, Error>) -> Void) -> Void, successMessage: String) {
        authState = .loading
        action { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.handleUserLogin(user: user, successMessage: successMessage)
                case .failure(let error):
                    self?.updateError(message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Login con Email y Contraseña
    func loginWithEmail() {
        guard validateFields([txtEmail, txtPassword]) else { return }
        authenticate(
            action: { FirebaseAuthService.shared.loginWithEmail(email: self.txtEmail, password: self.txtPassword, completion: $0) },
            successMessage: "¡Inicio de sesión exitoso!"
        )
    }
    
    // MARK: - Registro con Email y Contraseña
    func registerWithEmail() {
        guard validateFields([txtUsername, txtEmail, txtPassword]) else { return }
        authenticate(
            action: { FirebaseAuthService.shared.registerWithEmail(email: self.txtEmail, password: self.txtPassword, completion: $0) },
            successMessage: "¡Registro exitoso!"
        )
    }
    
    // MARK: - Login con Google
    func loginWithGoogle() {
        authenticate(
            action: { FirebaseAuthService.shared.loginWithGoogle(completion: $0) },
            successMessage: "¡Inicio de sesión con Google exitoso!"
        )
    }
    
    // MARK: - Login con Facebook
    func loginWithFacebook() {
        authenticate(
            action: { FirebaseAuthService.shared.loginWithFacebook(completion: $0) },
            successMessage: "¡Inicio de sesión con Facebook exitoso!"
        )
    }
    
    // MARK: - Manejo de Usuarios en la Base de Datos
    private func handleUserLogin(user: User, successMessage: String) {
        guard let email = user.email else {
            updateError(message: "No se pudo obtener el correo electrónico del usuario.")
            return
        }
        print(email)
        
        UserService.shared.getUserByEmail(email: email) { [weak self] result in
            DispatchQueue.main.async {
                print("Resultado de getUserByEmail:", result)
                switch result {
                case .success(let userModel):
                    if userModel.uid.isEmpty {
                        // Si el UID está vacío, tratamos como si no existiera el usuario
                        print("Usuario no encontrado, creando uno nuevo.")
                        self?.registerNewUser(user: user, email: email, successMessage: successMessage)
                    } else {
                        // Usuario encontrado, cargar datos
                        self?.userObj = userModel
                        self?.setUserData(userModel: userModel, user: user)
                        self?.updateSuccess(message: successMessage)
                    }
                case .failure:
                    print("Error al buscar usuario, creando uno nuevo.")
                    self?.registerNewUser(user: user, email: email, successMessage: successMessage)
                }
            }
        }
    }
    
    // MARK: - Registro de nuevo User en la Base de Datos
    private func registerNewUser(user: User, email: String, successMessage: String) {
        if !txtUsername.isEmpty {
            // Registro para usuario sin proveedor
            let newUser = CreateUserNoProviderModel(username: txtUsername, email: email)
            UserService.shared.createUserNoProvider(user: newUser) { [weak self] createResult in
                DispatchQueue.main.async {
                    switch createResult {
                    case .success(let createdUser):
                        let userModel = UserModel(uid: createdUser.uid!,
                                                  username: newUser.username,
                                                  name: user.displayName ?? "",
                                                  email: newUser.email,
                                                  mobile: user.phoneNumber ?? "")
                        self?.setUserData(userModel: userModel, user: user)
                        self?.updateSuccess(message: "¡Registro exitoso!")
                    case .failure(let error):
                        self?.updateError(message: "Error al registrar usuario: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            // Registro para usuario con proveedor
            let newUser = CreateUserWithProviderModel(email: email)
            UserService.shared.createUserWithProvider(user: newUser) { [weak self] createResult in
                DispatchQueue.main.async {
                    switch createResult {
                    case .success(let createdUser):
                        let userModel = UserModel(uid: createdUser.uid!,
                                                  username: user.displayName ?? "",
                                                  name: user.displayName ?? "",
                                                  email: newUser.email,
                                                  mobile: user.phoneNumber ?? "")
                        self?.setUserData(userModel: userModel, user: user)
                        self?.updateSuccess(message: "¡Registro exitoso!")
                    case .failure(let error):
                        self?.updateError(message: "Error al registrar usuario: \(error.localizedDescription)")
                    }
                }
            }
        }
    }


    // MARK: - Validación de Campos
    private func validateFields(_ fields: [String]) -> Bool {
        for field in fields where field.isEmpty {
            updateError(message: "Todos los campos son obligatorios.")
            return false
        }
        return true
    }

    // MARK: - Manejo de Mensajes
    private func updateSuccess(message: String) {
        successMessage = message
        showSuccess = true
        isUserLogin = true
        authState = .success(message: message)
    }

    private func updateError(message: String) {
        errorMessage = message
        showError = true
        authState = .error(message: message)
    }

    // MARK: - Guardar Datos del Usuario (Localmente)
    func setUserData(userModel: UserModel, user: User) {
        userObj = UserModel(uid: userModel.uid,
                            username: userModel.username,
                            name: userModel.name,
                            email: userModel.email,
                            mobile: userModel.mobile)
        
        isUserLogin = true
        authState = .authenticated(user: user)
        clearFields()
    }

    // MARK: - Limpiar Campos
    private func clearFields() {
        txtUsername = ""
        txtEmail = ""
        txtPassword = ""
        isShowPassword = false
    }
}
