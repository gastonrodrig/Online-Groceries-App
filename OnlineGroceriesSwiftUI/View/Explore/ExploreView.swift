//
//  ExploreView.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 11/01/25.
//

import SwiftUI

struct ExploreView: View {

    @StateObject var exploreVM = ExploreViewModel.shared
    
    var columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    
                    Spacer()
                    
                    Text("Find Products")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                }
                .padding(.top, .topInsets)
                
                SearchTextField(placeholder: "Search Category", txt: $exploreVM.txtSearch)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 4)
                
                Spacer()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(exploreVM.listArr, id: \.id) { cObject in
                            
                            NavigationLink(destination: ExploreItemView(itemsVM: ExploreItemViewModel(catObj: cObject))) {
                                ExploreCategoryCell(cObject: cObject)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .padding(.bottom, .bottomInsets + 60)
                }
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationView {
        ExploreView()
    }
}
