//
//  FailedToSignUpView.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 19.05.2025.
//

import SwiftUI

struct FailedToSignUpView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var failedMessage: String?

    var body: some View {
        MessageAlertComponent(image: .emailIsAlreadyRegistered, title: failedMessage ?? "Something went wrong") {
            dismiss()
        }
        .navigationBarHidden(true)

    }
}

#Preview {
    FailedToSignUpView()
}
