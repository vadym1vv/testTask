//
//  MainRouterEnum.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import Foundation
import SwiftUI

//main navigation enum
enum MainRouterEnum: CaseIterable {
    case users, signUp
    
    //displays selected screen
    @ViewBuilder
    var screen: some View {
        switch self {
        case .users:
            UsersView()
        case .signUp:
            SignUpView()
        }
    }
    
    //navigation tab(button) description
    var bottomNavigationDescription: String {
        switch self {
        case .users:
            "Users"
        case .signUp:
            "Sign up"
        }
    }
    
    //navigation tab(button) icon
    var bottomNavigationIcon: String {
        switch self {
        case .users:
            IconEnum.users.icon
        case .signUp:
            IconEnum.signUp.icon
        }
    }
    
    //navigation page title
    var pageTitle: String {
        switch self {
        case .users:
            "Working with GET request"
        case .signUp:
            "Working with POST request"
        }
    }
}
