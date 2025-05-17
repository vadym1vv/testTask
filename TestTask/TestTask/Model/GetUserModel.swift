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
//    let links: Links?
    let users: [UrlUser]?
    
    enum CodingKeys: String, CodingKey {
        case success, page
        case totalPages = "total_pages"
        case totalUsers = "total_users"
        case count, /*links,*/ users
    }
}

// MARK: - Links
//struct Links: Codable {
//    let nextURL: String?
//    let prevURL: JSONNull?
//    
//    enum CodingKeys: String, CodingKey {
//        case nextURL = "next_url"
//        case prevURL = "prev_url"
//    }
//}

// MARK: - User
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

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//    
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//    
//    public var hashValue: Int {
//        return 0
//    }
//    
//    public init() {}
//    
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//    
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
