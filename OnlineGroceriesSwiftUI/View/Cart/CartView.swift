//
//  CartView.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 25/01/25.
//

import SwiftUI

struct CartView: View {
    
    @StateObject var cartVM = CartViewModel.shared
    
    var body: some View {
        ZStack {
            
            if cartVM.isLoading {
                ProgressView("Loading Cart...")
                    .font(.customfont(.bold, fontSize: 20))
                    .padding()
            } else if cartVM.cartItems.isEmpty {
                Text("Your Cart is Empty")
                    .font(.customfont(.bold, fontSize: 20))
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach($cartVM.cartItems, id: \.id) { $cObject in
                            CartItemRow(cObject: $cObject)
                        }
                        .padding(.vertical, 8)
                    }
                    .padding(20)
                    .padding(.top, .topInsets + 46)
                    .padding(.bottom, .bottomInsets + 60)
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("My Cart")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                }
                .padding(.top, .topInsets)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2)
                
                Spacer()
                
                RoundButton(title: "Check Out")
                    .padding(.horizontal, 20)
                    .padding(.bottom, .bottomInsets + 80)
            }
        
        }
        .onAppear {
            cartVM.fetchCartItemsByUser()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    CartView()
}
