//
//  UserModel.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import Foundation

struct GetUserModel: Codable, Hashable, DecodableType {
    let success: Bool?
    let page, totalPages, totalUsers, count: Int?
    let users: [UrlUser]?
    
    enum CodingKeys: String, CodingKey {
        case success, page
        case totalPages = "total_pages"
        case totalUsers = "total_users"
        case count, users
    }
}

struct UrlUser: Codable, Hashable {
    let id: Int?
    let name, email, phone, position: String?
    let positionID, registrationTimestamp: Int?
    let photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, position
        case positionID = "position_id"
        case registrationTimestamp = "registration_timestamp"
        case photo
    }
}
