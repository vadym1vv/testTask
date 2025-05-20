//
//  InternetConnectionView.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 19.05.2025.
//

import SwiftUI

struct InternetConnectionView: View {
    
    @EnvironmentObject private var networkMonitorVM: NetworkMonitorVM
    
    var failedMessage: String?

    var body: some View {
        VStack {
            MessageAlertComponent(image: .emailIsAlreadyRegistered, title: failedMessage ?? "There is no internet connection") {
                networkMonitorVM.checkConnectionWithPing()
            }
            .navigationBarHidden(true)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorEnum.backgroundColor.color)

    }
}

#Preview {
    InternetConnectionView()
}
