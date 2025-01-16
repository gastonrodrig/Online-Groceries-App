//
//  SectionTitleAll.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 12/01/25.
//

import SwiftUI

struct SectionTitleAll: View {
    var title: String
    var titleAll: String
    var didTap: (()->())?
    
    var body: some View {
        HStack {
            Text(title)
                .font(.customfont(.semibold, fontSize: 24))
                .foregroundColor(.primaryText)
            
            Spacer()
            
            Text(titleAll)
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.primaryApp)
        }
        .frame(height: 40)
    }
}

#Preview {
    SectionTitleAll(title: "Title", titleAll: "View All")
        .padding(20)
}
