//
//  LineTextField.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 30/12/24.
//

import SwiftUI

struct LineTextField: View {
    @Binding var txt: String
    @State var title: String = "Title"
    @State var placeholder: String = "Placeholder"
    @State var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack {
            Text(title)
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.textTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(placeholder, text: $txt)
                .keyboardType(keyboardType)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .frame(height: 40)
            
            Divider()
        }
    }
}

struct LineSecureField: View {
    @Binding var txt: String
    @Binding var isShowPassword: Bool
    var placeholder: String = "Enter your password"
    
    var body: some View {
        VStack {
            Text("Password")
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.textTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if isShowPassword {
                TextField(placeholder, text: $txt)
                    .modifier(ShowButton(isShow: $isShowPassword))
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .frame(height: 40)
            } else {
                SecureField(placeholder, text: $txt)
                    .modifier(ShowButton(isShow: $isShowPassword))
                    .textInputAutocapitalization(.never)
                    .frame(height: 40)
            }
            
            Divider()
        }
    }
}

#Preview {
    LineTextField(txt: .constant(""))
        .padding(20)
}
