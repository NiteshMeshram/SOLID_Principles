//
//  ProductListViewModel.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import Foundation

@MainActor
public final class ProductViewModel: ObservableObject {
    private let repository: ProductRepositoryProtocol

    @Published public private(set) var products: [Product] = []
    @Published public private(set) var isLoading: Bool = false
    @Published public private(set) var errorMessage: String?

    public init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }

    public func loadProducts() async {
        isLoading = true
        errorMessage = nil
        do {
            let result = try await repository.getAllProducts()
            products = result
        } catch {
            errorMessage = "Failed to load products: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
