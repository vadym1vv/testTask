//
//  MainView.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var mainRouterVM: MainRouterVM = MainRouterVM()
    
    var body: some View {
        VStack {
            Spacer()
            mainRouterVM.routerEnum.screen
            Spacer()
            NavigationComponent()
                .environmentObject(mainRouterVM)
        }
    }
}

#Preview {
    MainView()
}
