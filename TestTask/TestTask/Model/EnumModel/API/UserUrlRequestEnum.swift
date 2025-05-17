//
//  UserUrlRequestEnum.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import Foundation

enum UserUrlRequestEnum: APIClient.APISpec {
    case userByPage(page: Int, count: Int)
    
    var endpoint: String {
        switch self {
        case .userByPage(page: let page, count: let count):
            var components = URLComponents()
            components.path = "/users"
            components.queryItems = [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "count", value: String(count))
            ]
            return components.url?.absoluteString ?? ""
        }
    }
    
    var method: APIClient.HttpMethod {
        switch self {
        case .userByPage:
            return .get
        }
    }
    
    var returnType: any DecodableType.Type {
        switch self {
        case .userByPage:
            GetUserModel.self
        }
    }
    
    var body: Data? {
        switch self {
        case .userByPage:
            return nil
        }
    }
}
