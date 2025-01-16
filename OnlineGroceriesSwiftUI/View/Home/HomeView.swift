//
//  HomeView.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 11/01/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel.shared
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Image("color_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                    
                    HStack {
                        Image("location")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                        
                        Text("Lima, Peru")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.darkGray)
                    }
                    
                    SearchTextField(placeholder: "Search Store", txt: $homeVM.txtSearch)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                }
                .padding(.top, .topInsets)
                
                Image("banner_top")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 115)
                    .padding(.horizontal, 20)
                
                SectionTitleAll(title: "Exclusive offer", titleAll: "See All") {
                    
                }
                .padding(.horizontal, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 15) {
                        ForEach(0...5, id: \.self) { index in
                            
                            ProductCell(image: "banana",name: "Banana", text: "7pcs, price",price: "S/. 2,99") {
                                
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                }
                
                SectionTitleAll(title: "Best Selling", titleAll: "See All") {
                    
                }
                .padding(.horizontal, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 15) {
                        ForEach(0...5, id: \.self) { index in
                            
                            ProductCell(image: "banana",name: "Banana", text: "7pcs, price",price: "S/. 2,99") {
                                
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                }
                
                SectionTitleAll(title: "Groceries", titleAll: "See All") {
                    
                }
                .padding(.horizontal, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 15) {
                        ForEach(0...5, id: \.self) { index in
                            
                            CategoryCell(color: Color(hex: "F8A44C")) {
                                
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                }
                .padding(.bottom, 8)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 15) {
                        ForEach(0...5, id: \.self) { index in
                            
                            ProductCell(image: "banana",name: "Banana", text: "7pcs, price",price: "S/. 2,99") {
                                
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
