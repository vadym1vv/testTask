//
//  ValidationErrorResponse.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 19.05.2025.
//

import Foundation

//errors from server response
struct ValidationErrorResponse: Codable, Error, LocalizedError {
    let message: String?
    let fails: [String: [String]]?

    var errorDescription: String? {
        if let fails = fails, let first = fails.flatMap({ $0.value }).first {
            return first
        }
        return message ?? "An unknown error occurred."
    }
}
