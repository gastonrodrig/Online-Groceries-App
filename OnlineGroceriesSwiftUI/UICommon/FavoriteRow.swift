//
//  FavoriteRow.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 24/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteRow: View {
    @State var fObject: UserFavoriteModel = UserFavoriteModel(dict: [
        "id": "juv2JmJJWTHNZMo2x15d",
        "product": [
          "brandId": "SUfXxGsJlSUYtNFRHGDM",
          "unit_name": "bag",
          "price": 1.79,
          "name": "Baby Carrot",
          "detail": "These organic baby carrots are naturally sweet and crunchy. Grown with care, they’re perfect for snacking, dipping, or cooking.",
          "unit_value": 1,
          "categoryId": "SMpDCGt0Jz1Ub8kvbzM4",
          "nutrition_weight": "200g",
          "id": "o282Xa4JedThOh9S8ynd",
          "offer": [
            "price": 1.49,
            "start_date": "01-02-2025",
            "end_date": "28-02-2025"
          ],
          "review_count": 0,
          "rating": 0,
          "is_best_seller": false,
          "multimedia": [
            "id": "4sk7G7kmc1msvlNQa8RC",
            "nombre": "baby_carrot.png",
            "url": "https://storage.googleapis.com/parking-app-50382.firebasestorage.app/products/multimedia/1737311176163-baby_carrot.png",
            "tamanio": 504774
          ]
        ],
        "user": [
          "uid": "pNDMUdXYgaFzQvCt3093",
          "email": "gaston.rodriguez0410@gmail.com"
        ]
          
    ])
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                WebImage(url: URL(string: fObject.product.multimedia!.url))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 60, height: 80)
                
                VStack(spacing: 4) {
                    Text(fObject.product.name)
                        .font(.customfont(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(fObject.product.unit_value) \(fObject.product.unit_name), price")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                Text("S/ \(fObject.product.offer?.price ?? fObject.product.price, specifier: "%.2f")")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                
                Image("next")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
            }
            
            Divider()
        }
    }
}

#Preview {
    FavoriteRow()
}
