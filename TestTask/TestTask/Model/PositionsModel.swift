//
//  Positions.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import Foundation

struct  PositionsModel: Codable, Hashable, DecodableType {
    let positions: [Position]?
}

struct Position: Codable, Hashable {
    let id: Int?
    let name: String?
}

