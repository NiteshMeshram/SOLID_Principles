//
//  NetworkServiceProtocol.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import Foundation

/// Defines a higher-level service abstraction.
/// Uses NetworkClient internally but hides request/response details from the consumer.
public protocol NetworkServiceProtocol: Sendable {
    associatedtype Entity: Decodable & Sendable
    func fetchAll() async throws -> [Entity]
    func fetch(by id: Int) async throws -> Entity
}
