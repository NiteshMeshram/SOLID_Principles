//
//  DefaultCategoryService.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

public final class DefaultCategoryService: CategoryServiceProtocol {
    private let client: NetworkClientProtocol
    public init(client: NetworkClientProtocol) { self.client = client }

    public func fetchAllCategories() async throws -> [Category] {
        let endpoint = Endpoint<[Category]>.get("/categories")
        let request  = NetworkRequest(endpoint: endpoint)
        let response = try await client.send(request)
        return response.value
    }

    public func fetchCategory(by id: Int) async throws -> Category {
        let endpoint = Endpoint<Category>.get("/categories/\(id)")
        let request  = NetworkRequest(endpoint: endpoint)
        let response = try await client.send(request)
        return response.value
    }
}
