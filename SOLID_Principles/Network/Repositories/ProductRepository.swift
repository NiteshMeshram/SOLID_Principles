//
//  ProductRepository.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import Foundation

public protocol ProductRepositoryProtocol: Sendable {
    func getAllProducts() async throws -> [Product]
    func getProduct(by id: Int) async throws -> Product
}

public final class ProductRepository: ProductRepositoryProtocol {
    private let service: ProductServiceProtocol

    public init(service: ProductServiceProtocol) {
        self.service = service
    }

    public func getAllProducts() async throws -> [Product] {
        try await service.fetchAllProducts()
    }

    public func getProduct(by id: Int) async throws -> Product {
        try await service.fetchProduct(by: id)
    }
}
