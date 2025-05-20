//
//  SignUpView.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject private var userVM: UserVM
    @EnvironmentObject private var mainRouterVM: MainRouterVM

    @State private var isPressed = false
    @State private var navigateToFailedSignUpScreen: Bool = false
    @State private var navigateToSuccessfullyRegisteredScreen: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(isActive: $navigateToFailedSignUpScreen) {
                FailedToSignUpView(failedMessage: userVM.errorMessage)
            } label: {
                EmptyView()
            }
            
            NavigationLink(isActive: $navigateToSuccessfullyRegisteredScreen) {
                SuccessSingUpView()
                    .environmentObject(userVM)
                    .environmentObject(mainRouterVM)
            } label: {
                EmptyView()
            }
            
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack(spacing: 38) {
                        CustomTextField(inputText: $userVM.name, labelText: "Your name", minTextSize: 2, maxTextSize: 60, keyboardType: .default) { finalUserInput in
                            if (finalUserInput == nil || finalUserInput != nil && finalUserInput!.isEmpty) {
                                userVM.formContainsErrors = true
                                return "Required field"
                            } else {
                                userVM.formContainsErrors = false
                                return nil
                            }
                        }
                        
                        CustomTextField(inputText: $userVM.email, labelText: "Email", minTextSize: 5, maxTextSize: 40, keyboardType: .emailAddress) { finalUserInput in
                            if (finalUserInput == nil || (finalUserInput != nil && finalUserInput!.isEmpty)) {
                                userVM.formContainsErrors = true
                                return "Required field"
                            } else if(!userVM.isValidEmail(finalUserInput!)) {
                                userVM.formContainsErrors = true
                                return "Invalid email format"
                            } else {
                                userVM.formContainsErrors = false
                                return nil
                            }
                        }
                        
                        CustomTextField(inputText: $userVM.phone, labelText: "Phone", bottomFieldDescription: "+38 (XXX) XXX - XX - XX", minTextSize: 5, maxTextSize: 13, keyboardType: .phonePad) { finalUserInput in
                            if (finalUserInput == nil || (finalUserInput != nil && finalUserInput!.isEmpty)) {
                                userVM.formContainsErrors = true
                                return "Required field"
                            } else if (!finalUserInput!.contains("+380") || finalUserInput!.count != 13) {
                                userVM.formContainsErrors = true
                                return "Invalid phone number. It must start with +380"
                            } else {
                                userVM.formContainsErrors = false
                                return nil
                            }
                        }
                    }
                    .padding(.bottom, 24)
                    
                    HStack {
                        PositionComponent(selectedPosition: $userVM.selectedPosition, positions: userVM.positions)
                        Spacer()
                    }
                    
                    UploadPhotoComponent(photoPath: $userVM.photoPath)
                        .padding(.bottom, 34)
                    
                    Button {
                        Task {
                            await userVM.registrationRequest {
                                navigateToSuccessfullyRegisteredScreen = true
                            } registrationErrorAction: {
                                navigateToFailedSignUpScreen = true
                            }
                        }
                    } label: {
                        Text("Sing up")
                            .frame(width: 140, height: 48)
                            .background(userVM.formContainsErrors || !userVM.isSubmitAvailable ? ColorEnum.disabledButtonColor.color : ColorEnum.primColor.color)
                            .foregroundStyle(userVM.formContainsErrors || !userVM.isSubmitAvailable ? ColorEnum.black48.color : ColorEnum.black87.color)
                            .font(FontEnum.nutino18.font)
                    }
                    .clipShape(Capsule())
                    .scaleEffect(isPressed ? 0.95 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: isPressed)
                    .simultaneousGesture(
                        //Fix broken animation for a button inside a ScrollView - iOS bug
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                if (!userVM.formContainsErrors && userVM.isSubmitAvailable) {
                                    isPressed = true
                                }
                            }
                            .onEnded { _ in
                                if (!userVM.formContainsErrors && userVM.isSubmitAvailable) {
                                    isPressed = false
                                }
                            }
                    )
                    .disabled(userVM.formContainsErrors || !userVM.isSubmitAvailable)
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
        .environmentObject(MainRouterVM())
}



