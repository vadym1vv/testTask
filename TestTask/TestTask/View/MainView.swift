//
//  MainView.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var mainRouterVM: MainRouterVM = MainRouterVM()
    @StateObject private var userVM: UserVM = UserVM()
    
    var body: some View {
        VStack {
            Text(mainRouterVM.routerEnum.pageTitle)
                .padding()
                .frame(maxWidth: .infinity)
                .background(ColorEnum.primColor.color)
                .foregroundStyle(ColorEnum.schemesOnSurface.color)
                .padding(.top, 0.2)
            
            VStack {
                mainRouterVM.routerEnum.screen
                    .environmentObject(userVM)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            NavigationComponent()
                .environmentObject(mainRouterVM)
        }
    }
}

#Preview {
    MainView()
}
