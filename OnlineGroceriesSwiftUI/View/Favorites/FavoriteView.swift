//
//  FavoriteView.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 23/01/25.
//

import SwiftUI

struct FavoriteView: View {
    var body: some View {
        ZStack {
            VStack {
                
                HStack {
                    
                    Spacer()
                    
                    Text("Favorites")
                        .font(.customfont(.bold, fontSize: 20))
                    
                    Spacer()
                }
                .padding(.top, .topInsets)
                
                Spacer()
                
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    FavoriteView()
}
