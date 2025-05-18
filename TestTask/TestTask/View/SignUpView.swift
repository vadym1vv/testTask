//
//  SignUpView.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject private var userVM: UserVM
    
    @State private var name: String? = nil
    @State private var email: String? = nil
    @State private var phone: String? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack(spacing: 38) {
                        CustomTextField(inputText: $name, labelText: "Your name", minTextSize: 2, maxTextSize: 60, keyboardType: .default) { finalUserInput in
                            if (finalUserInput == nil || finalUserInput != nil && finalUserInput!.isEmpty) {
                                return "Required field"
                            } else {
                                return nil
                            }
                        }
                        
                        CustomTextField(inputText: $email, labelText: "Email", minTextSize: 5, maxTextSize: 40, keyboardType: .emailAddress) { finalUserInput in
                            if (finalUserInput == nil || (finalUserInput != nil && finalUserInput!.isEmpty)) {
                                return "Required field"
                            } else if(!userVM.isValidEmail(finalUserInput!)) {
                                return "Invalid email format"
                            } else {
                                return nil
                            }
                        }
                        
                        CustomTextField(inputText: $phone, labelText: "Phone", minTextSize: 5, maxTextSize: 30, keyboardType: .phonePad) { finalUserInput in
                            if (finalUserInput == nil || (finalUserInput != nil && finalUserInput!.isEmpty)) {
                                return "Required field"
                            } else if(!finalUserInput!.contains("+380")) {
                                return "Invalid phone number. It should contain: +380"
                            } else {
                                return nil
                            }
                        }
                    }
                    .padding(.bottom, 24)
                    
                    HStack {
                        PositionComponent(selectedPosition: $userVM.selectedPosition, positions: userVM.positions)
                        Spacer()
                    }
                }
                .padding(16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            await userVM.getPositions()
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(UserVM())
}



