//
//  NetworkRequest.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

//import Foundation
//
//public enum HTTPMethod: String, Sendable {
//    case get = "GET", post = "POST", put = "PUT", patch = "PATCH", delete = "DELETE"
//}
//
//public typealias HTTPHeaders = [String: String]
//
///// A small value type describing an HTTP request (SRP).
//public struct NetworkRequest: Sendable, Equatable {
//    public let endpoint: Endpoint           // 👈 replaced `path` with `endpoint`
//    public let method: HTTPMethod
//    public let headers: HTTPHeaders
//    public let body: Data?
//
//    public init(
//        endpoint: Endpoint,
//        method: HTTPMethod = .get,
//        headers: HTTPHeaders = ["Accept": "application/json"],
//        body: Data? = nil
//    ) {
//        self.endpoint = endpoint
//        self.method = method
//        self.headers = headers
//        self.body = body
//    }
//}
//
//// MARK: - Convenience helpers
//public extension NetworkRequest {
//    static func get(_ path: String, query: [URLQueryItem]? = nil, headers: HTTPHeaders = [:]) -> Self {
//        .init(endpoint: Endpoint(path: path, query: query), method: .get, headers: headers)
//    }
//
//    static func jsonPOST<T: Encodable>(_ payload: T, to path: String, headers: HTTPHeaders = [:]) throws -> Self {
//        let data = try JSONEncoder().encode(payload)
//        var merged = headers
//        merged["Content-Type"] = merged["Content-Type"] ?? "application/json"
//        return .init(endpoint: Endpoint(path: path), method: .post, headers: merged, body: data)
//    }
//}

import Foundation

public struct NetworkRequest<Response: Decodable & Sendable>: Sendable, Equatable {
    public let endpoint: Endpoint<Response>
    public init(endpoint: Endpoint<Response>) { self.endpoint = endpoint }
}
