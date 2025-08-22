//
//  ProductServiceTests.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/21/25.
//

import XCTest
@testable import SOLID_Principles

final class ProductServiceTests: XCTestCase {

    func test_fetchAllProducts_decodesSuccess() async throws {
        let mock = MockNetworkClient()
        let products = [
            Product(id: 1, name: "A", price: 10, description: nil, images: nil, category: nil),
            Product(id: 2, name: "B", price: 20, description: nil, images: nil, category: nil)
        ]
        try await mock.stubObject(products, for: "/products")   // <- await because actor

        let sut = DefaultProductService(client: mock)
        let result = try await sut.fetchAllProducts()

        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "A")
    }

    func test_fetchAllProducts_propagatesServerError() async {
        // Arrange
        let mock = MockNetworkClient()
        await mock.stubError(.unacceptableStatus(code: 500, data: nil), for: "/products") // 👈 add await
        let sut = DefaultProductService(client: mock)

        // Act/Assert
        do {
            _ = try await sut.fetchAllProducts()
            XCTFail("Expected to throw")
        } catch let error as NetworkError {
            switch error {
            case .unacceptableStatus(let code, _):
                XCTAssertEqual(code, 500)
            default:
                XCTFail("Unexpected error: \(error)")
            }
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }

}
