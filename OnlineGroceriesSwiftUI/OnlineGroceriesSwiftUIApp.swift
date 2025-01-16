//
//  OnlineGroceriesSwiftUIApp.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 27/12/24.
//

import SwiftUI

@main
struct OnlineGroceriesSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var authVM = AuthenticationViewModel.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if authVM.isUserLogin {
                    MainTabView()
                } else {
                    WelcomeView()
                }
            }
        }
    }
}
