//
//  MockProductRepository.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/21/25.
//

import Foundation
@testable import SOLID_Principles

// Simple, zero-dependency mock for tests
final class MockProductRepository: ProductRepositoryProtocol {
    let productsToReturn: [Product]
    let errorToThrow: Error?

    init(productsToReturn: [Product] = [], errorToThrow: Error? = nil) {
        self.productsToReturn = productsToReturn
        self.errorToThrow = errorToThrow
    }

    func getAllProducts() async throws -> [Product] {
        if let error = errorToThrow { throw error }
        return productsToReturn
    }

    func getProduct(by id: Int) async throws -> Product {
        if let error = errorToThrow { throw error }
        return productsToReturn.first { $0.id == id } ?? Product(
            id: id,
            name: "Test Product \(id)",
            price: 1.0,
            description: nil,
            images: nil,
            category: nil
        )
    }
}
