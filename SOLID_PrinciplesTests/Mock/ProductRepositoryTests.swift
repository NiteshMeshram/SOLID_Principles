//
//  ProductRepositoryTests.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/21/25.
//

import XCTest
@testable import SOLID_Principles

final class ProductRepositoryTests: XCTestCase {
    func test_repo_passesThroughServiceData() async throws {
        // Use a super-light mock repository if you prefer,
        // or back it with the ProductService + MockNetworkClient:
        let mock = MockNetworkClient()
        let products = [Product(id: 1, name: "X", price: 1, description: nil, images: nil, category: nil)]
        try await mock.stubObject(products, for: "/products")

        let service = DefaultProductService(client: mock)
        let repo = ProductRepository(service: service)

        let result = try await repo.getAllProducts()
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "X")
    }
}
