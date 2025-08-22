//
//  DefaultProductService.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

public final class DefaultProductService: ProductServiceProtocol {
    private let client: NetworkClientProtocol
    public init(client: NetworkClientProtocol) { self.client = client }

    public func fetchAllProducts() async throws -> [Product] {
        let endpoint = Endpoint<[Product]>.get("/products")
        let request  = NetworkRequest(endpoint: endpoint)
        let response = try await client.send(request)
        return response.value
    }

    public func fetchProduct(by id: Int) async throws -> Product {
        let endpoint = Endpoint<Product>.get("/products/\(id)")
        let request  = NetworkRequest(endpoint: endpoint)
        let response = try await client.send(request)
        return response.value
    }
}
