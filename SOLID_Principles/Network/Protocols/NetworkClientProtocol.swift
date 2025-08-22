//
//  NetworkClientProtocol.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import Foundation

public protocol NetworkClientProtocol: Sendable {
    func send<T: Decodable & Sendable>(_ request: NetworkRequest<T>) async throws -> NetworkResponse<T>
}
