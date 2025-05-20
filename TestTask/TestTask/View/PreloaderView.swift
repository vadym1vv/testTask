//
//  Preloader.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import SwiftUI

struct PreloaderView: View {
    
    @State private var navigationToMainView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(isActive: $navigationToMainView) {
                    MainView()
                } label: {
                    EmptyView()
                }
                
                Image(IconEnum.logo.icon)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorEnum.primColor.color)
            .onAppear {
                //3 sec interval for pre loaded screen
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                    navigationToMainView = true
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    PreloaderView()
}
