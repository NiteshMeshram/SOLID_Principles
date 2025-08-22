//
//  ProductServiceProtocol.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import Foundation

/// Abstraction for product-related operations.
public protocol ProductServiceProtocol: Sendable {
    func fetchAllProducts() async throws -> [Product]
    func fetchProduct(by id: Int) async throws -> Product
}
