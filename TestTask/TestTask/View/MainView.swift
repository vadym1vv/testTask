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
    @StateObject private var networkMonitorVM = NetworkMonitorVM()
    
    var body: some View {
        VStack(spacing: 0) {
            //check for network connection
            if (!networkMonitorVM.isConnected) {
                InternetConnectionView()
                    .environmentObject(networkMonitorVM)
                    .onAppear {
                        userVM.resetUserInput()
                    }
            } else {
                Text(mainRouterVM.routerEnum.pageTitle)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(ColorEnum.primColor.color, ignoresSafeAreaEdges: .bottom)
                    .foregroundStyle(ColorEnum.schemesOnSurface.color)
                VStack {
                    mainRouterVM.routerEnum.screen
                        .environmentObject(userVM)
                        .environmentObject(mainRouterVM)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                NavigationComponent()
                    .environmentObject(userVM)
                    .environmentObject(mainRouterVM)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorEnum.backgroundColor.color)
        .navigationBarHidden(true)
    }
}

#Preview {
    MainView()
}
