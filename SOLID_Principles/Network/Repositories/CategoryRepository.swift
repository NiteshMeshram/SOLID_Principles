//
//  CategoryRepository.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import Foundation

public protocol CategoryRepositoryProtocol: Sendable {
    func getAllCategories() async throws -> [Category]
    func getCategory(by id: Int) async throws -> Category
}

public final class CategoryRepository: CategoryRepositoryProtocol {
    private let service: CategoryServiceProtocol

    public init(service: CategoryServiceProtocol) {
        self.service = service
    }

    public func getAllCategories() async throws -> [Category] {
        try await service.fetchAllCategories()
    }

    public func getCategory(by id: Int) async throws -> Category {
        try await service.fetchCategory(by: id)
    }
}
