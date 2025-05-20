//
//  CameraPicker.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 18.05.2025.
//

import SwiftUI
import UIKit

struct CameraPicker: UIViewControllerRepresentable {
    @Binding var imagePath: String?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CameraPicker

        init(_ parent: CameraPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    let filename = getDocumentsDirectory().appendingPathComponent(UUID().uuidString + ".jpg")
                    try? imageData.write(to: filename)
                    parent.imagePath = filename.path
                }
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        
        func getDocumentsDirectory() -> URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }
    }
}
