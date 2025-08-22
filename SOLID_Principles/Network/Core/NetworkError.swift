//
//  NetworkError.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import Foundation

/// Unified error model for networking.
public enum NetworkError: Error, Sendable {
    case invalidURL
    case transport(URLError)
    case invalidResponse
    case unacceptableStatus(code: Int, data: Data?)
    case decoding(Error)
    case encoding(Error)
}

// MARK: - Equatable
extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.invalidResponse, .invalidResponse):
            return true
        case (.transport(let e1), .transport(let e2)):
            return e1.code == e2.code
        case (.unacceptableStatus(let c1, _), .unacceptableStatus(let c2, _)):
            return c1 == c2
        case (.decoding, .decoding),
             (.encoding, .encoding):
            // We can’t compare Error directly, so treat as equal by case
            return true
        default:
            return false
        }
    }
}

// MARK: - Helpers
public extension NetworkError {
    var isRetriable: Bool {
        switch self {
        case .transport(let err):
            return [.networkConnectionLost,
                    .timedOut,
                    .cannotConnectToHost].contains(err.code)
        case .unacceptableStatus(let code, _):
            return (500...599).contains(code)
        default:
            return false
        }
    }
}
