//
//  SearchTextField.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 12/01/25.
//

import SwiftUI

struct SearchTextField: View {
    var placeholder: String
    @Binding var txt: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image("search")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            TextField(placeholder, text: $txt)
                .font(.customfont(.regular, fontSize: 17))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .frame(height: 30)
        .padding(15)
        .background(Color(hex: "F2F2F2"))
        .cornerRadius(16)
    }
}

#Preview {
    SearchTextField(placeholder: "Ola🙄", txt: .constant(""))
        .padding(20)
}
