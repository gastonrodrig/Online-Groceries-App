//
//  ExploreItemView.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 25/01/25.
//

import SwiftUI

struct ExploreItemView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var itemsVM: ExploreItemViewModel
    
    var columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    
                    Spacer()
                    
                    Text(itemsVM.cObj.name)
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image("filter_ic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                }
            
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(itemsVM.listArr, id: \.id) { pObj in
                            ProductCell(pObject: pObj, width: .infinity)
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.bottom, .bottomInsets + 60)
                }
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    ExploreItemView(
        itemsVM: ExploreItemViewModel(
            catObj: CategoryModel(
                dict: [
                    "id": "SMpDCGt0Jz1Ub8kvbzM4",
                    "name": "Fresh Vegetables",
                    "description": "Healthy and fresh vegetables"
                ]
            )
        )
    )
}
