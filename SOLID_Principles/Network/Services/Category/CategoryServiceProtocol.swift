//
//  CategoryServiceProtocol.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import Foundation

/// Abstraction for category-related operations.
public protocol CategoryServiceProtocol: Sendable {
    func fetchAllCategories() async throws -> [Category]
    func fetchCategory(by id: Int) async throws -> Category
}
