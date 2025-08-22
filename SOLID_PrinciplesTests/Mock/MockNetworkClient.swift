//
//  MockNetworkClient.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/21/25.
//

import Foundation
@testable import SOLID_Principles

/// Minimal API mock that isolates mutable state via actor (Swift 6 safe).
actor MockNetworkClient: NetworkClientProtocol {
    enum Mode: Sendable {
        case success(Data, status: Int = 200)
        case failure(NetworkError)
    }

    // Path -> stubbed outcome
    private var stubs: [String: Mode] = [:]
    private let decoder = JSONDecoder()

    // MARK: - Stubbing helpers
    func stub(path: String, data: Data, status: Int = 200) {
        stubs[path] = .success(data, status: status)
    }

    func stubObject<T: Encodable>(_ object: T, for path: String, status: Int = 200) throws {
        let data = try JSONEncoder().encode(object)
        stub(path: path, data: data, status: status)
    }

    func stubError(_ error: NetworkError, for path: String) {
        stubs[path] = .failure(error)
    }

    // MARK: - NetworkClientProtocol
    func send<T: Decodable & Sendable>(_ request: NetworkRequest<T>) async throws -> NetworkResponse<T> {
        let ep = request.endpoint
        print("Mock NetworkClient : \(ep)")
        guard let mode = stubs[ep.path] else {
            throw NetworkError.invalidURL
        }

        switch mode {
        case .failure(let err):
            throw err

        case .success(let data, let status):
            guard (200..<300).contains(status) else {
                throw NetworkError.unacceptableStatus(code: status, data: data)
            }
            do {
                let value = try decoder.decode(T.self, from: data)
                return NetworkResponse(value: value, response: nil)
            } catch {
                throw NetworkError.decoding(error)
            }
        }
    }
}
