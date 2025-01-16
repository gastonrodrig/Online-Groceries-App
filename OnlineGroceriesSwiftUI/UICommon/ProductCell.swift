//
//  ProductCell.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 12/01/25.
//

import SwiftUI

struct ProductCell: View {
    var image: String
    var name: String
    var text: String
    var price: String
    var didAddCart: (()->())?
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 80)
            
            Spacer()
            
            Text(name)
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Text(text)
                .font(.customfont(.medium, fontSize: 14))
                .foregroundColor(.secondaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            HStack {
                Text(price)
                    .font(.customfont(.medium, fontSize: 18))
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

#Preview {
    ProductCell(image: "banana",name: "Banana", text: "7pcs, price",price: "S/. 2,99")
}
