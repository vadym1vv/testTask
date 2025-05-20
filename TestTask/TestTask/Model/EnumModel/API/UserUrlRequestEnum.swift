//
//  UserUrlRequestEnum.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import Foundation

enum UserUrlRequestEnum: APIClient.APISpec {
    
    
    
    case userByPage(page: Int, count: Int), positions, registrationRequest(registrationRequestModel: RegistrationRequestModel), token
    //creates url request with properties
    var endpoint: String {
        var components = URLComponents()
        switch self {
        case .userByPage(page: let page, count: let count):
            components.path = "/users"
            components.queryItems = [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "count", value: String(count))
            ]
            return components.url?.absoluteString ?? ""
        case .positions:
            components.path = "/positions"
            return components.url?.absoluteString ?? ""
        case .registrationRequest:
            components.path = "/users"
            return components.url?.absoluteString ?? ""
        case .token:
            components.path = "/token"
            return components.url?.absoluteString ?? ""
        }
    }
    
    var method: APIClient.HttpMethod {
        switch self {
        case .userByPage:
            return .get
        case .positions:
            return .get
        case .registrationRequest:
            return .post
        case .token:
            return .get
        }
    }
    
    var returnType: any DecodableType.Type {
        switch self {
        case .userByPage:
            GetUserModel.self
        case .positions:
            PositionsModel.self
        case .registrationRequest:
            SuccessRegistrationModel.self
        case .token:
            TokenModel.self
        }
    }
    
    var body: Data? {
        switch self {
        case .userByPage, .positions, .token:
            return nil
        case .registrationRequest(let model):
                    guard let boundary = multipartBoundary else { return nil }
                    return createMultipartBody(model: model, boundary: boundary)
                }
    }
    
    var isMultipart: Bool {
            switch self {
            case .registrationRequest:
                return true
            default:
                return false
            }
        }

        var multipartBoundary: String? {
            switch self {
            case .registrationRequest:
                return "Boundary-\(UUID().uuidString)"
            default:
                return nil
            }
        }
}

func createMultipartBody(model: RegistrationRequestModel, boundary: String) -> Data {
    var body = Data()
    let boundaryPrefix = "--\(boundary)\r\n"

    func addFormField(name: String, value: String) {
        body.append(Data(boundaryPrefix.utf8))
        body.append(Data("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".utf8))
        body.append(Data("\(value)\r\n".utf8))
    }

    func addFileField(name: String, filename: String, mimeType: String, fileData: Data) {
        body.append(Data(boundaryPrefix.utf8))
        body.append(Data("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n".utf8))
        body.append(Data("Content-Type: \(mimeType)\r\n\r\n".utf8))
        body.append(fileData)
        body.append(Data("\r\n".utf8))
    }

    addFormField(name: "name", value: model.name)
    addFormField(name: "email", value: model.email)
    addFormField(name: "phone", value: model.phone)
    addFormField(name: "position_id", value: "\(model.position_id)")
    addFileField(name: "photo", filename: "upload.jpg", mimeType: "image/jpeg", fileData: model.photo)

    body.append(Data("--\(boundary)--\r\n".utf8))

    return body
}

private extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
