//
//  RegistrationRequistModel.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 18.05.2025.
//

import Foundation

struct RegistrationRequestModel: Codable, Hashable, DecodableType {
    let name: String
    let email: String
    let phone: String
    let position_id: Int
    let photo: Data
}
