//
//  UserVM.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import Foundation
import UIKit

@MainActor
class UserVM: ParentApiRequestVM <UserUrlRequestApiService> {
    
    //MARK: - users page
    @Published var users: [UrlUser] = []
    @Published var currentPage: Int = 0
    @Published var isLastPage: Bool = false
    
    //MARK: - sign up form
    @Published var positions: [Position] = []
    @Published var selectedPosition: Position?
    
    @Published var name: String?
    @Published var email: String?
    @Published var phone: String?
    @Published var photoPath: String?
    
    @Published var errorMessage: String?
    @Published var formContainsErrors: Bool = false
    
    var isSubmitAvailable: Bool {
        guard let name, let email, let phone, let photoPath, let selectedPosition, selectedPosition.id != nil else {
            return false
        }
        
        return !name.isEmpty && !email.isEmpty && !phone.isEmpty && !photoPath.isEmpty
    }
    
    func getUsers() async {
        
        let getUsersUrlRequestModel: GetUserModel? = await apiService.fetchUsersList(page: currentPage + 1, count: 6)
        if let usersUrlRequestModel = getUsersUrlRequestModel, let totlaPages = usersUrlRequestModel.totalPages, var users = usersUrlRequestModel.users, let page = usersUrlRequestModel.page  {
            if (totlaPages <= (currentPage + 1)) {
                isLastPage = true
            }
            currentPage = page
            users.sort { ($0.registrationTimestamp ?? 0) > ($1.registrationTimestamp ?? 0) }
            self.users.append(contentsOf: users)
        }
    }
    
    func getPositions() async {
        
        guard positions.isEmpty else {
            return
        }
        
        let getPositionsModel: PositionsModel? = await apiService.fetchPositionsList()
        if let positions = getPositionsModel?.positions {
            self.positions = positions
            selectedPosition = positions.first
        }
    }
    
    func registrationRequest(successAction: @escaping () -> (), registrationErrorAction: @escaping () -> ()) async {
        errorMessage = nil
        //check for nil/empty value
        if !isSubmitAvailable {
            #if DEBUG
            fatalError("submit was performed with nil value(s)")
            #else
            return
            #endif
        }

        guard let photoPath = photoPath else {
                print("photoPath is nil")
                return
            }

            let fileURL = URL(fileURLWithPath: photoPath)
            guard let imageData = try? Data(contentsOf: fileURL) else {
                print("Failed to load image data.")
                return
            }
            
            // Check if compression is needed (>5MB), compress only then, else use original data
            let fiveMB = 5 * 1024 * 1024
            let finalImageData: Data
            if imageData.count > fiveMB,
               let compressedData = resizeAndCompressIfNeeded(photoPath: photoPath, maxSize: CGSize(width: 2000, height: 2000), compressionQuality: 0.95) {
                finalImageData = compressedData
                print("Compressed image size: \(Double(compressedData.count) / 1_048_576) MB")
            } else {
                finalImageData = imageData
                print("Using original image data size: \(Double(imageData.count) / 1_048_576) MB")
            }
        
        let registrationRequestModel: RegistrationRequestModel = RegistrationRequestModel(name: name!, email: email!, phone: phone!, position_id: selectedPosition!.id!, photo: finalImageData)
        
        do {
            
            /*
             new token request at each user registration push request according to:
             -The token is valid for 40 minutes and can be used for only one request.
             -For the next registration, you will need to get a new one.
             */
            let token = await updateToken()
            let _ = try await apiService.registrationRequest(registrationRequestModel: registrationRequestModel, token: token)
            //navigate action to success view
            successAction()
        } catch {
            let message = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
            errorMessage = message
            //navigate action to error view + error message
            registrationErrorAction()
        }
    }
    
    private func updateToken() async -> String? {
        let getNewTokenReqRes: TokenModel? = await apiService.fetchNewToken()
        return getNewTokenReqRes?.token
    }
    
    //dismiss user previous input
    func resetUserInput() {
        if let firstPosition = positions.first {
            selectedPosition = firstPosition
        }
        currentPage = 0
        users = []
        name = nil
        email = nil
        phone = nil
        photoPath = nil
        formContainsErrors = false
    }
    
    //email validation
    func isValidEmail(_ email: String) -> Bool {
        let regex = #"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
}

func resizeAndCompressIfNeeded(photoPath: String, maxSize: CGSize = CGSize(width: 1080, height: 1080), compressionQuality: CGFloat = 0.7) -> Data? {
    let fileURL = URL(fileURLWithPath: photoPath)
    
    // Check file size in bytes (5 MB = 5 * 1024 * 1024)
    guard let originalData = try? Data(contentsOf: fileURL) else {
        print("Failed to load image data.")
        return nil
    }
    
    let fiveMB = 5 * 1024 * 1024
    guard originalData.count > fiveMB else {
        // Return original if it's already under 5MB
        return originalData
    }
    
    // Load image from data
    guard let image = UIImage(data: originalData) else {
        print("Invalid image data.")
        return nil
    }
    
    // Resize image
    let resizedImage = image.resized(toMaxSize: maxSize)
    
    // Compress image
    guard let compressedData = resizedImage.jpegData(compressionQuality: compressionQuality) else {
        print("Compression failed.")
        return nil
    }

    return compressedData
}

extension UIImage {
    func resized(toMaxSize maxSize: CGSize) -> UIImage {
        let aspectWidth = maxSize.width / size.width
        let aspectHeight = maxSize.height / size.height
        let aspectRatio = min(aspectWidth, aspectHeight)

        let newSize = CGSize(width: size.width * aspectRatio, height: size.height * aspectRatio)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
