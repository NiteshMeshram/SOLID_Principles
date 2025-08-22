//
//  ProductViewModelTests.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/21/25.
//

import XCTest
@testable import SOLID_Principles

@MainActor
final class ProductViewModelTests: XCTestCase {

    func test_loadProducts_success() async {
        // Arrange: hardcoded products (no files)
        let products = [
            Product(id: 1, name: "A", price: 10, description: nil, images: nil, category: nil),
            Product(id: 2, name: "B", price: 20, description: nil, images: nil, category: nil)
        ]
        let repo = MockProductRepository(productsToReturn: products)
        let vm = ProductViewModel(repository: repo)

        // Act
        await vm.loadProducts()

        // Assert
        XCTAssertFalse(vm.isLoading)
        XCTAssertNil(vm.errorMessage)
        XCTAssertEqual(vm.products.count, 2)
        XCTAssertEqual(vm.products.first?.name, "A")
    }

    func test_loadProducts_error() async {
        struct DummyError: Error {}
        let repo = MockProductRepository(errorToThrow: DummyError())
        let vm = ProductViewModel(repository: repo)

        await vm.loadProducts()

        XCTAssertFalse(vm.isLoading)
        XCTAssertNotNil(vm.errorMessage)
        XCTAssertTrue(vm.products.isEmpty)
    }
}
