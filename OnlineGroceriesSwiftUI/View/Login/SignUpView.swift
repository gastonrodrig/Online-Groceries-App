//
//  SignUpView.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 3/01/25.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var registerVM = AuthenticationViewModel.shared
    
    var body: some View {
        ZStack {
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            ScrollView {
                VStack {
                    Image("color_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .padding(.bottom, .screenWidth * 0.1)
                    
                    Text("Sign Up")
                        .font(.customfont(.semibold, fontSize: 26))
                        .foregroundColor(.primaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)
                    
                    Text("Enter your credentials to continue")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, .screenWidth * 0.1)
                    
                    LineTextField(txt: $registerVM.txtUsername, title: "Username", placeholder: "Enter your username")
                        .padding(.bottom, .screenWidth * 0.07)
                    
                    LineTextField(txt: $registerVM.txtEmail, title: "Email", placeholder: "Enter your email address", keyboardType: .emailAddress)
                        .padding(.bottom, .screenWidth * 0.07)
                    
                    LineSecureField(txt: $registerVM.txtPassword, isShowPassword: $registerVM.isShowPassword)
                        .padding(.bottom, .screenWidth * 0.04)
                    
                    VStack {
                        Text("By continuing you agree to our")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        HStack{
                            
                            Text("Terms of Service")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.primaryApp)
                                
                            
                            Text(" and ")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.secondaryText)
                                
                            
                            Text("Privacy Policy.")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.primaryApp)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                        }
                        .padding(.bottom, .screenWidth * 0.02)
                    }
                    
                    RoundButton(title: "Sing Up") {
                        AuthenticationViewModel.shared.registerWithEmail()
                    }
                    .padding(.bottom, .screenWidth * 0.05)
                    
                    NavigationLink {
                        LoginView()
                    } label: {
                        HStack {
                            Text("Alredy have an account?")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.primaryText)
                            
                            Text("Sign In")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.primaryApp)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, .topInsets + 64)
                .padding(.horizontal, 20)
                .padding(.bottom, .bottomInsets)
            }
            
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .alert(isPresented: $registerVM.showError) {
            Alert(
                title: Text("Error"),
                message: Text(registerVM.errorMessage),
                dismissButton: .default(Text("OK")) {
                    registerVM.errorMessage = ""
                }
            )
        }
    }
}

#Preview {
    NavigationView {
        SignUpView()
    }
}
