//
//  MainRouterVM.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import Foundation

class MainRouterVM: ObservableObject {
    @Published var routerEnum: MainRouterEnum = .users
    
    func performNavigation(screen: MainRouterEnum) {
        routerEnum = screen
    }
}
