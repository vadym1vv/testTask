//
//  BottomBarNavigationComponent.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import SwiftUI

struct NavigationComponent: View {
    
    @EnvironmentObject private var mainRouterVM: MainRouterVM
    
    var body: some View {
        HStack {
            ForEach(MainRouterEnum.allCases, id: \.self) { screen in
                Spacer()
                Button {
                    withAnimation {
                        mainRouterVM.performNavigation(screen: screen)
                    }
                } label: {
                    HStack {
                        Image(screen.bottomNavigationIcon)
                            .renderingMode(.template)
                            .foregroundStyle(screen == mainRouterVM.routerEnum ? ColorEnum.secondColor.color : ColorEnum.unselectedColor.color)
                        
                        Text(screen.bottomNavigationDescription)
                            .font(FontEnum.nutino16.font)
                            .foregroundStyle(screen == mainRouterVM.routerEnum ? ColorEnum.secondColor.color : ColorEnum.unselectedColor.color)
                    }
                    
                }
                .padding(.vertical)
                Spacer()
            }
        }
        .background(ColorEnum.lightGray.color)
    }
}

#Preview {
    NavigationComponent()
        .environmentObject(MainRouterVM())
}
