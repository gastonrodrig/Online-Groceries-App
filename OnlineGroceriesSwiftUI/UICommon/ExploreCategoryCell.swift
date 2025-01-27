//
//  ExploreCategoryCell.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 25/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreCategoryCell: View {
    @State var cObject: CategoryModel = CategoryModel(dict: [
        "id": "SMpDCGt0Jz1Ub8kvbzM4",
        "name": "Fresh Vegetables",
        "description": "descripcion",
        "multimedia": [
          "id": "tN5O83IcZgANT6DjLOgX",
          "url": "https://storage.googleapis.com/parking-app-50382.firebasestorage.app/categories/multimedia/1737335959455-fresh vegetable.png",
          "nombre": "fresh vegetable.png",
          "tamanio": 9841805
        ]
    ])
    var didAddCart: (()->())?
    
    var body: some View {
//        NavigationLink(
//           destination: ProductDetailView(detailVM: ProductDetailViewModel(prodObj: pObject))
//        ) {
            VStack {
                WebImage(url: URL(string: cObject.multimedia!.url))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 120, height: 90)
                
                Spacer()
                
                Text(cObject.name)
                    .font(.customfont(.bold, fontSize: 16))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            }
            .padding(15)
            .background(Color.yellow.opacity(0.3))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.yellow, lineWidth: 1)
            )
//        }
    }
}

#Preview {
    ExploreCategoryCell()
}
