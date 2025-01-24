//
//  CategoryCell.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 12/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryCell: View {
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
        HStack {
            WebImage(url: URL(string: cObject.multimedia!.url))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(width: 70, height: 70)
            
            Spacer()
            
            Text(cObject.name)
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.secondaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(15)
        .frame(width: 250, height: 100)
        .background(Color.yellow.opacity(0.3))
        .cornerRadius(16)
    }
}

#Preview {
    CategoryCell()
}
