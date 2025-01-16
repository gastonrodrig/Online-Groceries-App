//
//  MainTabView.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 11/01/25.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var homeVM = HomeViewModel.shared
    
    var body: some View {
        VStack {
            TabView(selection: $homeVM.selectTab) {
                HomeView().tag(0)
                ExploreView().tag(1)
                ExploreView().tag(2)
                ExploreView().tag(3)
                ExploreView().tag(4)
            }
            .onAppear {
                UIScrollView.appearance().isScrollEnabled = false
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: homeVM.selectTab) { newValue in
                print("Selected Tab: \(newValue)")
            }
            
            HStack {
                TabButton(title: "Shop", icon: "store_tab", isSelect: homeVM.selectTab == 0) {
                    DispatchQueue.main.async {
                        withAnimation {
                            homeVM.selectTab = 0
                        }
                    }
                }
                TabButton(title: "Explore", icon: "explore_tab", isSelect: homeVM.selectTab == 1) {
                    DispatchQueue.main.async {
                        withAnimation {
                            homeVM.selectTab = 1
                        }
                    }
                }
                TabButton(title: "Cart", icon: "cart_tab", isSelect: homeVM.selectTab == 2) {
                    DispatchQueue.main.async {
                        withAnimation {
                            homeVM.selectTab = 2
                        }
                    }
                }
                TabButton(title: "Favourite", icon: "fav_tab", isSelect: homeVM.selectTab == 3) {
                    DispatchQueue.main.async {
                        withAnimation {
                            homeVM.selectTab = 3
                        }
                    }
                }
                TabButton(title: "Account", icon: "account_tab", isSelect: homeVM.selectTab == 4) {
                    DispatchQueue.main.async {
                        withAnimation {
                            homeVM.selectTab = 4
                        }
                    }
                }
            }
            .padding(.top, 10)
            .padding(.bottom, .bottomInsets)
            .padding(.horizontal, 10)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: -2)
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    MainTabView()
}
