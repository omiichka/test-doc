//
//  ServiceError.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import Foundation

enum ServiceError: Error, LocalizedError {
    case invalidURL(String)
    case castError(String)
    case requestError(Int)
    case decodeError(Error)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case let .invalidURL(url):
            return "Invalid url: \(url)"
        case let .castError(url):
            return "Error while casting response for url: \(url)"
        case let .requestError(code):
            return "Request failed with status code: \(code)"
        case let .decodeError(error):
            return "Error while decoding data: \(error)"
        case let .unknown(error):
            return error.localizedDescription
        }
    }
}
