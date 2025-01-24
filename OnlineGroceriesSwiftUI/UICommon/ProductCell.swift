//
//  ProductCell.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 12/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCell: View {
    @State var pObject: ProductModel = ProductModel(dict: [
        "unit_name": "pcs",
        "price": 1.99,
        "name": "Organic Apple",
        "detail": "An organic apple is grown without the use of synthetic pesticides or fertilizers. It has a fresh, natural flavor with a crisp and juicy texture. Its cultivation follows sustainable agricultural practices, making it a healthier and more eco-friendly choice.",
        "unit_value": 10,
        "nutrition_weight": "150g",
        "id": "gDwv8QJSZIJhKUYc3viZ",
        "rating": 0,
        "review_count": 0,
        "is_best_seller": false,
        "category": [
            "id": "heNO1BKc7WUf2kTkLZZR",
            "name": "Fresh Fruits",
            "description": "description fruit"
        ],
        "brand": [
            "id": "SUfXxGsJlSUYtNFRHGDM",
            "name": "Plump",
            "description": "descripcion plump"
        ],
        "multimedia": [
            "id": "mlksFjj4N4pEpKYRSVd6",
            "nombre": "apple.png",
            "url": "https://storage.googleapis.com/parking-app-50382.firebasestorage.app/products/multimedia/1737167639504-apple.png",
            "tamanio": 10559910
        ]
    ])
    var didAddCart: (()->())?
    
    var body: some View {
        NavigationLink(
            destination: ProductDetailView(detailVM: ProductDetailViewModel(prodObj: pObject))
        ) {
            VStack {
                
                WebImage(url: URL(string: pObject.multimedia!.url))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 100, height: 80)
                
                Spacer()
                
                Text(pObject.name)
                    .font(.customfont(.bold, fontSize: 16))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text("\(pObject.unit_value) \(pObject.unit_name), price")
                    .font(.customfont(.medium, fontSize: 14))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                HStack {
                    Text("S/ \(pObject.offer?.price ?? pObject.price, specifier: "%.2f")")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Button {
                        didAddCart?()
                    } label: {
                        Image("add")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.primaryApp)
                    .cornerRadius(15)
                }
            }
            .padding(15)
            .frame(width: 180, height: 230)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.placeholder.opacity(0.5), lineWidth: 1)
            }
        }
    }
}

#Preview {
    ProductCell()
}
