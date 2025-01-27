//
//  CartRow.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 26/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartItemRow: View {
    @StateObject var cartVM = CartViewModel.shared
    @Binding var cObject: CartModel
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                WebImage(url: URL(string: cObject.product.multimedia!.url))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 60, height: 80)
                
                    VStack(spacing: 4) {
                        HStack {
                            Text(cObject.product.name)
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(.primaryText)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Button {
                                cartVM.removeItem(for: cObject.product)
                            } label: {
                                Image("close")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                            }
                        }
                        
                        Text("\(cObject.product.unit_value) \(cObject.product.unit_name), price")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                        
                        HStack {
                            Button {
                                cartVM.decreaseQuantityOrRemove(for: cObject.product)
                            } label: {
                                Image("subtack")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                            }
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.placeholder.opacity(0.5), lineWidth: 1)
                            )
                            
                            Text(" \(cObject.quantity) ")
                                .font(.customfont(.bold, fontSize: 24))
                                .foregroundColor(.primaryText)
                                .frame(width: 45, height: 45)
                            
                            Button {
                                cartVM.increase_1_Quantity(for: cObject.product)
                            } label: {
                                Image("add_green")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                            }
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.placeholder.opacity(0.5), lineWidth: 1)
                            )
                            
                            Spacer()
                            
                            Text("S/ \( (cObject.product.offer?.price ?? cObject.product.price) * Double(cObject.quantity), specifier: "%.2f")")
                                .font(.customfont(.bold, fontSize: 18))
                                .foregroundColor(.primaryText)
                        }
                    }

            }
            
            Divider()
        }
    }
}

#Preview {
    @State var sampleCartItem = CartModel(dict: [
        "id": "7OIBSYJHZpE39M0GrWIN",
        "quantity": 3,
        "product": [
            "brandId": "SUfXxGsJlSUYtNFRHGDM",
            "unit_name": "pcs",
            "price": 1.79,
            "name": "Organic Pear",
            "detail": "The organic pear is grown sustainably without synthetic chemicals, ensuring a sweet, juicy fruit with a tender texture. Ideal for snacking or adding to desserts, this pear is a healthy and eco-friendly option.",
            "unit_value": 6,
            "categoryId": "heNO1BKc7WUf2kTkLZZR",
            "nutrition_weight": "180g",
            "id": "LBCziGjIUKgWQuyxin6t",
            "offer": [
                "price": 1.59,
                "start_date": "01-02-2025",
                "end_date": "28-02-2025"
            ],
            "review_count": 0,
            "rating": 0,
            "is_best_seller": true,
            "multimedia": [
                "id": "2FDoeWKg9aGr7qHqnJuc",
                "nombre": "pear.png",
                "url": "https://storage.googleapis.com/parking-app-50382.firebasestorage.app/products/multimedia/1737309632825-pear.png",
                "tamanio": 455133
            ]
        ],
        "user": [
            "uid": "pNDMUdXYgaFzQvCt3093",
            "email": "gaston.rodriguez0410@gmail.com"
        ]
    ])
    
    CartItemRow(cObject: $sampleCartItem)
        .padding(.horizontal, 20)
}
