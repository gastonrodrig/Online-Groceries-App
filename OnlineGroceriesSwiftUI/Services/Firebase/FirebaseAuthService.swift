//
//  FirebaseAuthService.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 31/12/24.
//

import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import FBSDKLoginKit

class FirebaseAuthService {
    static let shared = FirebaseAuthService()

    private init() {}

    // MARK: - Login con Email y Contraseña
    func loginWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let user = authResult?.user {
                completion(.success(user))
            } else {
                completion(.failure(NSError(domain: "FirebaseAuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])))
            }
        }
    }

    // MARK: - Logout
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }

    // MARK: - Registro de Usuario
    func registerWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let user = authResult?.user {
                completion(.success(user))
            } else {
                completion(.failure(NSError(domain: "FirebaseAuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])))
            }
        }
    }
    
    
    // MARK: - Login con Google
    func loginWithGoogle(completion: @escaping (Result<User, Error>) -> Void) {
        // Obtiene el clienteID del info.plist
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(NSError(domain: "FirebaseAuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing Firebase client ID"])))
            return
        }

        // Configuración de Google Sign-In
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Obtiene el controlador que presenta
        guard let presenting = UIApplication.shared.windows.first?.rootViewController else {
            completion(.failure(NSError(domain: "FirebaseAuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve presenting view controller"])))
            return
        }

        // Inicia el flujo de autenticación
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { result, error in
            if let error = error {
                print("Google Sign-In failed with error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            // Verifica si se pudo obtener el usuario de Google, y su token de acceso
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                completion(.failure(NSError(domain: "FirebaseAuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve user or token from Google Sign-In"])))
                return
            }

            // Crea las credenciales de Google para Firebase Authentication
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Authentication failed with error: \(error.localizedDescription)")
                    completion(.failure(error))
                } else if let user = authResult?.user {
                    print("Firebase Authentication succeeded for user: \(user.email ?? "Unknown email")")
                    completion(.success(user))
                } else {
                    completion(.failure(NSError(domain: "FirebaseAuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error during Firebase Authentication"])))
                }
            }
        }
    }

    // MARK: - Login con Facebook
    func loginWithFacebook(completion: @escaping (Result<User, Error>) -> Void) {
        // Inicializa el administrador de inicio de sesión de Facebook
        let loginManager = LoginManager()
        
        // Obtiene el controlador que presenta
        guard let presenting = UIApplication.shared.windows.first?.rootViewController else {
            completion(.failure(NSError(domain: "FirebaseAuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve presenting view controller"])))
            return
        }
        
        // Inicia el flujo de autenticación
        loginManager.logIn(permissions: ["public_profile", "email"], from: presenting) { result, error in
            if let error = error {
                print("Facebook Login failed with error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            // Verifica si se pudo obtener el token de acceso de Facebook
            guard let token = AccessToken.current?.tokenString else {
                completion(.failure(NSError(domain: "FirebaseAuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Facebook Login failed to retrieve access token"])))
                return
            }

            // Crea las credenciales de Facebook para Firebase Authentication
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Authentication with Facebook failed with error: \(error.localizedDescription)")
                    completion(.failure(error))
                } else if let user = authResult?.user {
                    print("Firebase Authentication succeeded for user: \(user.email ?? "Unknown email")")
                    completion(.success(user))
                } else {
                    completion(.failure(NSError(domain: "FirebaseAuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error during Firebase Authentication with Facebook"])))
                }
            }
        }
    }

}
