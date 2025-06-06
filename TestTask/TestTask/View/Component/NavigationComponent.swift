//
//  BottomBarNavigationComponent.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import SwiftUI

struct NavigationComponent: View {
    
    @EnvironmentObject private var mainRouterVM: MainRouterVM
    @EnvironmentObject private var userVM: UserVM
    
    var body: some View {
        HStack {
            ForEach(MainRouterEnum.allCases, id: \.self) { screen in
                Spacer()
                Button {
                    //change screen/prevent from unneeded page refresh by tap
                    if screen != mainRouterVM.routerEnum {
                        withAnimation {
                            userVM.resetUserInput()
                            mainRouterVM.performNavigation(screen: screen)
                        }
                    }
                } label: {
                    HStack {
                        Image(screen.bottomNavigationIcon)
                            .renderingMode(.template)
                            .foregroundStyle(screen == mainRouterVM.routerEnum ? ColorEnum.secondColor.color : ColorEnum.black60.color)
                        
                        Text(screen.bottomNavigationDescription)
                            .font(FontEnum.nutino16.font)
                            .foregroundStyle(screen == mainRouterVM.routerEnum ? ColorEnum.secondColor.color : ColorEnum.black60.color)
                    }
                }
                .padding(.vertical)
                Spacer()
            }
        }
        .background(ColorEnum.customLightGray.color)
    }
}

#Preview {
    NavigationComponent()
        .environmentObject(MainRouterVM())
}
