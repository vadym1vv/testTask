//
//  NetworkError.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(statusCode: Int)
    case invalidResponse
    case dataConversionFailure
    case decodingFailed(underlyingError: Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server response was invalid."
        case .requestFailed(let statusCode):
            return "Request failed with status code \(statusCode)."
        case .decodingFailed(let error):
            return "Failed to decode the server response: \(error.localizedDescription)"
        case .dataConversionFailure:
            return "Unable to convert the server response into usable data."
        case .invalidURL:
            return "invalid address request"
        }
    }
}
