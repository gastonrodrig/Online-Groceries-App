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

    var body: some Scene {
        WindowGroup {
            NavigationView {
                WelcomeView()
            }
        }
    }
}
