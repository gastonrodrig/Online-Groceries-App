//
//  TabButton.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 11/01/25.
//

import SwiftUI

struct TabButton: View {
    
    var title: String = "Title"
    var icon: String = "store_tab"
    var isSelect: Bool = false
    var didSelect: (()->())?
    
    var body: some View {
        Button {
            print("tab button")
            didSelect?()
        } label: {
            VStack {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text(title).font(.customfont(.semibold, fontSize: 14))
            }
        }
        .foregroundColor( isSelect ? .primaryApp : .primaryText)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

#Preview {
    TabButton()
}
