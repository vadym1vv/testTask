//
//  CustomTextField.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import SwiftUI

struct CustomTextField: View {
    
    @FocusState private var focusState: Bool
    
//    @State private var isFormValid: Bool = true
    @State private var errorMessage: String?
    
    @Binding var inputText: String?
    
    
    var labelText: String
//    var errorMessage: String
    var minTextSize: Int
    var maxTextSize: Int
    var keyboardType: UIKeyboardType
//    var updateInputStatusFunc: (_ : TextInputStatusEnum) -> ()
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
//            .onChange(of: inputText ?? "") { newValue in
//                if (newValue.count > 1 && inputText != nil && !inputText!.isEmpty) {
//                    if(newValue.count > maxTextSize - 1) {
//                        updateInputStatusFunc(.error)
//                    } else {
//                        updateInputStatusFunc(.focused)
//                    }
//                    inputText = String(newValue.prefix(maxTextSize))
//                }
//                else if (newValue == " ") {
//                    inputText = newValue.trimmingCharacters(in: .whitespaces)
//                }
//            }
            .onChange(of: inputText ?? "") { newValue in
                if (newValue.count > minTextSize && inputText != nil && !inputText!.isEmpty) {
//                    if(newValue.count > maxTextSize - 1) {
////                        updateInputStatusFunc(.error)
//                    } else {
////                        updateInputStatusFunc(.none)
//                    }
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
//                        updateInputStatusFunc(.empty)
                    } else {
//                        updateInputStatusFunc(.none)
                    }
                }
                errorMessage = additionalValidationCheck(inputText)
            }
            .onTapGesture {
//                scrollTextFieldToTopFunc()
//                showAdditionalEmptySpaceForTextField = true
//                isRatingNameTextFieldFocused = true
//                updateInputStatusFunc(.focused)
            }
            .padding(.leading)
            .foregroundStyle(ColorEnum.black87.color)
//            .focused($isRatingNameTextFieldFocused)
//            .onChange(of: isRatingNameTextFieldFocused) { newValue in
//                showAdditionalEmptySpaceForTextField = newValue
//            }
            .onChange(of: focusState) { newValue in
                
               
//                showAdditionalEmptySpaceForTextField = newValue
                if (!newValue) {
                    errorMessage = additionalValidationCheck(inputText)
                }
            }
        }
        .frame(height: 56)
        .foregroundStyle(ColorEnum.circleBorderColor.color)
        .overlay {
            RoundedRectangle(cornerRadius: 4)
//
//                .border(isFormValid ? ColorEnum.circleBorderColor.color : ColorEnum.error.color, width: 1)
//                .clipShape(RoundedRectangle(cornerRadius: 4))
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
            
//                .padding(5)
        }
        .overlay(alignment: .bottomLeading) {
            if let errorMessage {
                Text(errorMessage)
                    .font(FontEnum.nutino14.font)
                    .foregroundStyle(ColorEnum.error.color)
                    .padding(.leading)
                    .offset(y: 25)
            
            }
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
