//
//  HomeViewModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by Gaston Rodriguez on 11/01/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    static let shared: HomeViewModel = HomeViewModel()
    
    @Published var selectTab: Int = 0
    @Published var txtSearch: String = ""
}
