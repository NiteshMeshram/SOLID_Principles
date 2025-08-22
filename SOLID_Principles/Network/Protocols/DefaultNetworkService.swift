//
//  DefaultNetworkService.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import Foundation

/// Generic, reusable service that conforms to your domain-style protocol.
/// You can use this for Products, Categories, etc., by choosing `E` and `basePath`.
public final class DefaultNetworkService<E: Decodable & Sendable>: NetworkServiceProtocol {
    public typealias Entity = E

    private let client: NetworkClientProtocol
    private let basePath: String     // e.g. "/products", "/categories"

    public init(client: NetworkClientProtocol, basePath: String) {
        self.client = client
        self.basePath = basePath
    }

    public func fetchAll() async throws -> [E] {
        // Build generic Endpoint<[E]>, wrap in NetworkRequest<[E]>, then send
        let endpoint = Endpoint<[E]>.get(basePath)
        let request  = NetworkRequest(endpoint: endpoint)
        let response = try await client.send(request)
        return response.value
    }

    public func fetch(by id: Int) async throws -> E {
        let endpoint = Endpoint<E>.get("\(basePath)/\(id)")
        let request  = NetworkRequest(endpoint: endpoint)
        let response = try await client.send(request)
        return response.value
    }
}

