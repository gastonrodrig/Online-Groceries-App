//
//  FavoriteView.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 23/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteView: View {

    @StateObject var favVM = FavoriteViewModel.shared
    
    var body: some View {
        ZStack {
            
            ScrollView {
                LazyVStack {
                    ForEach(favVM.favListArr, id: \.id, content: {
                        fObject in
                        
                        FavoriteRow(fObject: fObject)
                    })
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
            }
            
            VStack {
                
                HStack {
                    
                    Spacer()
                    
                    Text("Favorites")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                }
                .padding(.top, .topInsets)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2)
                
                Spacer()
                
                RoundButton(title: "Add to Cart")
                    .padding(.horizontal, 20)
                    .padding(.bottom, .bottomInsets + 80)
            }
        }
        .onAppear {
            favVM.fetchFavoritesByUser()
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
