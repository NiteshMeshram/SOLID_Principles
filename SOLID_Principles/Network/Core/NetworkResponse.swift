//
//  NetworkResponse.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import Foundation

/// A generic container for network responses.
/// Holds both the decoded model and the raw response if needed.
public struct NetworkResponse<T: Decodable & Sendable>: Sendable {
    /// The decoded model object
    public let value: T
    
    /// The raw HTTP response (optional)
    public let response: HTTPURLResponse?
    
    public init(value: T, response: HTTPURLResponse?) {
        self.value = value
        self.response = response
    }
}
