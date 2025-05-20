//
//  MessageAlertCompoent.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 19.05.2025.
//

import SwiftUI

struct MessageAlertComponent: View {
    
    let image: IconEnum
    let title: String
    var actionDescription: String = "Try again"
    let action: () -> ()
    
    var body: some View {
        VStack(spacing: 24) {
            Image(image.icon)
            Text(title)
                .font(FontEnum.nutino20.font)
                
            Button {
                action()
            } label: {
                Text(actionDescription)
                    .frame(width: 140, height: 48)
                    .font(FontEnum.nutino18.font)
                    .background(ColorEnum.primColor.color)
                    
            }
            .clipShape(Capsule())

        }
        .foregroundStyle(ColorEnum.black87.color)
    }
}

#Preview {
    MessageAlertComponent(image: .noInternetConnection, title: "There is no internet connection", action: {})
}
