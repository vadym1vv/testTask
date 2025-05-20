//
//  UploadPhotoComponent.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 18.05.2025.
//

import SwiftUI
import AVFoundation
import Photos

struct UploadPhotoComponent: View {
    
    @State private var showImageSelectOptions: Bool = false
    @State private var showPhotoPicker: Bool = false
    @State private var showCameraPicker: Bool = false
    @State private var showErrorMessage: Bool = false
    
    @Binding var photoPath: String?
    
    var body: some View {
        HStack {
            Text(photoPath ?? "Select photo")
                .font(FontEnum.nutino20.font)
                .foregroundStyle(showErrorMessage && photoPath == nil ? ColorEnum.error.color : ColorEnum.black48.color)
                .lineLimit(1)
                .padding(.leading)
            Spacer()
            Button{
                showImageSelectOptions.toggle()
            } label: {
                Text("Upload")
                    .font(FontEnum.nutino16.font)
                    .foregroundStyle(ColorEnum.secondaryDark.color)
            }
            .padding(.trailing)
            .confirmationDialog("Cho0se how you want to add a photo", isPresented: $showImageSelectOptions, titleVisibility: .visible, actions: {
                Button(action: {
                    let photos = PHPhotoLibrary.authorizationStatus()
                    if photos == .notDetermined {
                        PHPhotoLibrary.requestAuthorization({ status in
                            if status == .authorized{
                                showPhotoPicker.toggle()
                            }
                        })
                    } else if (photos == .authorized) {
                        showPhotoPicker.toggle()
                    }
                    
                }, label: {
                    Text("Open Gallery")
                })
                
                Button(action: {
                    AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                        if response {
                            showCameraPicker.toggle()
                        }
                    }
                }, label: {
                    Text("Take Photo")
                })
                
                Button(role: .cancel) {
                    showErrorMessage = true
                    showPhotoPicker = false
                } label: {
                    Text("Cancel")
                }
            })
            .fullScreenCover(isPresented: $showPhotoPicker, content: {
                PhotoPicker(imagePath: $photoPath)
                    .ignoresSafeArea()
            })
            .fullScreenCover(isPresented: $showCameraPicker) {
                CameraPicker(imagePath: $photoPath)
                    .ignoresSafeArea()
            }
        }
        .frame(height: 56)
        .overlay {
            RoundedRectangle(cornerRadius: 4)
                .stroke(lineWidth: 1)
                .foregroundStyle((photoPath == nil && showErrorMessage) ? ColorEnum.error.color : ColorEnum.circleBorderColor.color)
        }
        .overlay(alignment: .bottomLeading) {
            if (showErrorMessage && photoPath == nil) {
                Text("Photo is required")
                    .font(FontEnum.nutino14.font)
                    .foregroundStyle(ColorEnum.error.color)
                    .padding(.leading)
                    .offset(y: 25)
            }
        }
    }
}

#Preview {
    UploadPhotoComponent(photoPath: .constant(nil))
}
