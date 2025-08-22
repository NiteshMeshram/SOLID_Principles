//
//  Endpoint.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import Foundation

public enum HTTPMethod: String, Sendable {
    case get = "GET", post = "POST", put = "PUT", patch = "PATCH", delete = "DELETE"
}

public struct Endpoint<Response: Decodable & Sendable>: Sendable, Equatable {
    public let path: String
    public let method: HTTPMethod
    public let queryItems: [URLQueryItem]
    public let headers: [String: String]
    public let body: Data?

    public init(
        path: String,
        method: HTTPMethod = .get,
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:],
        body: Data? = nil
    ) {
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
    }
}

public extension Endpoint {
    static func get(_ path: String,
                    queryItems: [URLQueryItem] = [],
                    headers: [String:String] = [:]) -> Self {
        .init(path: path, method: .get, queryItems: queryItems, headers: headers)
    }
}




