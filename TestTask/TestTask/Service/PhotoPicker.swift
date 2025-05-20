//
//  PhotoPicker.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 18.05.2025.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @State private var image: UIImage?
    @Binding var imagePath: String?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true, completion: nil)
            
            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else { return }
            
            provider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    if let uiImage = image as? UIImage {
                        self.parent.image = uiImage
                        self.saveImageToLocal(image: uiImage)
                    }
                }
            }
        }

        func saveImageToLocal(image: UIImage) {
            guard let data = image.jpegData(compressionQuality: 0.8) else { return }
            
            let filename = UUID().uuidString + ".jpg"
            let fileURL = getDocumentsDirectory().appendingPathComponent(filename)

            do {
                try data.write(to: fileURL)
                parent.imagePath = fileURL.path
            } catch {
                print(error)
            }
        }

        func getDocumentsDirectory() -> URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }
    }
}
