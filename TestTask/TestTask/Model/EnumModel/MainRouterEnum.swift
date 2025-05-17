//
//  MainRouterEnum.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import Foundation
import SwiftUI

enum MainRouterEnum: CaseIterable {
    case users, signUp
    
    @ViewBuilder
    var screen: some View {
        switch self {
        case .users:
            UsersView()
        case .signUp:
            SignUpView()
        }
    }
    
    var bottomNavigationDescription: String {
        switch self {
        case .users:
            "Users"
        case .signUp:
            "Sign up"
        }
    }
    
    var bottomNavigationIcon: String {
        switch self {
        case .users:
            IconEnum.users.icon
        case .signUp:
            IconEnum.signUp.icon
        }
    }
}
