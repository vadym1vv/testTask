//
//  CustomTextField.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import SwiftUI

//reusable text field
struct CustomTextField: View {
    
    @FocusState private var focusState: Bool
    
    @State private var errorMessage: String?
    
    @Binding var inputText: String?
    
    var labelText: String
    var bottomFieldDescription: String? = nil
    var minTextSize: Int
    var maxTextSize: Int
    var keyboardType: UIKeyboardType
    //additional validation fro field: email, phone...
    var additionalValidationCheck: (String?) -> (String?)
    
    var body: some View {
        HStack {
            TextField(
                text: Binding(
                    get: { inputText ?? "" },
                    set: { newName in
                        inputText = newName
                    }
                ),
                label: {
                    Text(labelText)
                        .foregroundStyle(errorMessage != nil ? ColorEnum.error.color : ColorEnum.black48.color)
                        .font(FontEnum.nutino20.font)
                }
            )
            .keyboardType(keyboardType)
            .offset(y: focusState || (!focusState && inputText != nil && !inputText!.isEmpty && errorMessage != nil) ? 5 : 0)
            .focused($focusState)
            .onChange(of: inputText ?? "") { newValue in
                if (newValue.count > minTextSize && inputText != nil && !inputText!.isEmpty) {
                    //drop custom-field error validation
                    errorMessage = nil
                    inputText = String(newValue.prefix(maxTextSize))
                } else if (newValue == " ") {
                    inputText = newValue.trimmingCharacters(in: .whitespaces)
                }
            }
            .onSubmit {
                if let ratingKeyWord = inputText {
                    if(ratingKeyWord.count < 3) {
                        self.inputText = ""
                    }
                }
                // custom-field error validation
                errorMessage = additionalValidationCheck(inputText)
            }
            .padding(.leading)
            .foregroundStyle(ColorEnum.black87.color)
            .onChange(of: focusState) { newValue in
                if (!newValue) {
                    // custom-field error validation
                    errorMessage = additionalValidationCheck(inputText)
                }
            }
        }
        .frame(height: 56)
        .foregroundStyle(ColorEnum.circleBorderColor.color)
        .overlay {
            RoundedRectangle(cornerRadius: 4)
                .stroke(lineWidth: 1)
                .foregroundStyle(errorMessage == nil ? ColorEnum.circleBorderColor.color : ColorEnum.error.color)
        }
        .overlay(alignment: .topLeading) {
            if(focusState || (!focusState && inputText != nil && !inputText!.isEmpty)) {
                Text(labelText)
                    .font(FontEnum.nutino14.font)
                    .foregroundStyle(errorMessage == nil ? ColorEnum.black87.color : ColorEnum.error.color)
                    .padding(.leading)
            }
        }
        .overlay(alignment: .bottomLeading) {
            VStack {
                if let errorMessage {
                    Text(errorMessage)
                        .font(FontEnum.nutino14.font)
                        .foregroundStyle(ColorEnum.error.color)
                } else {
                    if let bottomFieldDescription {
                        Text(bottomFieldDescription)
                            .font(FontEnum.nutino14.font)
                            .foregroundStyle(ColorEnum.black60.color)
                    }
                }
            }
            .padding(.leading)
            .offset(y: 25)
        }
    }
}

#Preview {
    VStack {
        CustomTextField(inputText: .constant(nil), labelText: "Your Name", minTextSize: 3, maxTextSize: 6, keyboardType: .emailAddress) { finalUserInput in
            return "Required Field"
        }
    }
    .padding(.horizontal)
}
