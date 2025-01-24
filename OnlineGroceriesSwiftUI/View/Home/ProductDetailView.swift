//
//  ProductDetailView.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 20/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var detailVM: ProductDetailViewModel
    
    var body: some View {
        ZStack {
            
            ScrollView {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(hex: "F2F2F2"))
                        .frame(width: .screenWidth, height: .screenWidth * 0.8)
                        .cornerRadius(50, corner: [.bottomLeft, .bottomRight])
                    
                    WebImage(url: URL(string: detailVM.pObj.multimedia!.url))
                        .resizable()
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFit()
                        .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.8)
                }
                .frame(width: .screenWidth, height: .screenWidth * 0.8)
                
                VStack {
                    HStack {
                        Text(detailVM.pObj.name)
                            .font(.customfont(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                        Button {
                            detailVM.toggleFavorite()
                        } label: {
                            Image(detailVM.isFav ? "favorite" : "fav")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        .foregroundColor(Color.secondaryText)
                    }
                    
                    Text("\(detailVM.pObj.unit_value) \(detailVM.pObj.unit_name), Price")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        
                        Button {
                            detailVM.addSubQTY(isAdd: false)
                        } label: {
                            Image("subtack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(15)
                        }
                        
                        Text(" \(detailVM.qty) ")
                            .font(.customfont(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .frame(width: 45, height: 45)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.placeholder.opacity(0.5), lineWidth: 1)
                            )
                        
                        Button {
                            detailVM.addSubQTY()
                        } label: {
                            Image("add_green")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(15)
                        }
                        
                        Spacer()
                        
                        Text("S/ \( (detailVM.pObj.offer?.price ?? detailVM.pObj.price) * Double(detailVM.qty), specifier: "%.2f")")
                            .font(.customfont(.bold, fontSize: 28))
                            .foregroundColor(.primaryText)
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                VStack {
                    HStack {
                        Text("Product Detail")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                        Button {
                            withAnimation {
                                detailVM.showDetail()
                            }
                        } label: {
                            Image(detailVM.isShowDetail ? "detail_open" : "next")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(15)
                        }
                        .foregroundColor(Color.secondaryText)
                    }
                    
                    if(detailVM.isShowDetail) {
                        Text(detailVM.pObj.detail)
                            .font(.customfont(.medium, fontSize: 13))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                    }
                    
                    
                    Divider()
                }
                .padding(.horizontal, 20)
                
                VStack {
                    HStack {
                        Text("Nutritions")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Text(detailVM.pObj.nutrition_weight)
                            .font(.customfont(.semibold, fontSize: 10))
                            .foregroundColor(.secondaryText)
                            .padding(8)
                            .background(Color.placeholder.opacity(0.5))
                            .cornerRadius(5)
                            
                        Button {
                            withAnimation {
                                detailVM.showNutrition()
                            }
                        } label: {
                            Image(detailVM.isShowNutrition ? "detail_open" : "next")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(15)
                        }
                        .foregroundColor(Color.secondaryText)
                    }
                    
                    if(detailVM.isShowNutrition) {
                        LazyVStack {
                            ForEach(detailVM.nutritionArr, id: \.id) { nObj in
                                HStack {
                                    Text(nObj.nutrition_name)
                                        .font(.customfont(.semibold, fontSize: 15))
                                        .foregroundColor(.secondaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(nObj.nutrition_value)
                                        .font(.customfont(.semibold, fontSize: 15))
                                        .foregroundColor(.primaryText)
                                }
                                
                                Divider()
                            }
                            .padding(.vertical, 0)
                        }
                        .padding(.horizontal, 10)
                    }
                    
                    Divider()
                }
                .padding(.horizontal, 20)
                
                HStack(spacing: 2) {
                    Text("Review")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(1...5, id: \.self) { index in
                        
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.orange)
                            .frame(width: 15, height: 15)
                    }
                        
                    Button {
                        
                    } label: {
                        Image("next")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .padding(15)
                    }
                    .foregroundColor(Color.secondaryText)
                }
                .padding(.horizontal, 20)
                
                RoundButton(title: "Add to Basket") {
                    
                }
                .padding(20)
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
                    
                    Button {
                    } label: {
                        Image("share")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                }
                
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    ProductDetailView(
            detailVM: ProductDetailViewModel(
                prodObj: ProductModel(
                    dict: [
                        "unit_name": "bag",
                        "price": 3.49,
                        "name": "Red Grape",
                        "detail": "These seedless red grapes are organically grown, bursting with sweetness and crispness. Perfect for snacking, adding to salads, or making smoothies.",
                        "unit_value": 1,
                        "nutrition_weight": "500g",
                        "id": "O2z50RY41PM82pdGcxeV",
                        "offer": [
                            "price": 2.99,
                            "start_date": "01-02-2025",
                            "end_date": "28-02-2025"
                        ],
                        "review_count": 0,
                        "rating": 0,
                        "is_best_seller": true,
                        "category": [
                            "id": "heNO1BKc7WUf2kTkLZZR",
                            "name": "Fresh Fruits",
                            "multimediaId": "rHEXW2zE8kXQPAALi7xh",
                            "description": "descripcion"
                        ],
                        "brand": [
                            "id": "SUfXxGsJlSUYtNFRHGDM",
                            "name": "Plump",
                            "description": "descripcion plump"
                        ],
                        "multimedia": [
                            "id": "8v0P4ifQXaYE5gLUgcJn",
                            "nombre": "grape.png",
                            "url": "https://storage.googleapis.com/parking-app-50382.firebasestorage.app/products/multimedia/1737310221000-grape.png",
                            "tamanio": 4196420
                        ]
                    ]
                )
            )
        )
}
