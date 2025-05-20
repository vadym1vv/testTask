//
//  SuccessSingUpView.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 19.05.2025.
//

import SwiftUI

struct SuccessSingUpView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var mainRouterVM: MainRouterVM
    @EnvironmentObject private var userVM: UserVM
    
    var body: some View {
        MessageAlertComponent(image: .userRegistered, title: "User successfully registered", actionDescription: "Got it") {
            userVM.resetUserInput()
            mainRouterVM.performNavigation(screen: .users)
            dismiss()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SuccessSingUpView()
        .environmentObject(MainRouterVM())
        .environmentObject(UserVM())
}
