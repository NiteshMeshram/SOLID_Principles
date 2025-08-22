//
//  ProductListView.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import SwiftUI

public struct ProductListView: View {
    @StateObject private var viewModel: ProductViewModel

    public init(viewModel: ProductViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            } else {
                List(viewModel.products, id: \.id) { product in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product.name) // 👈 FIXED
                            .font(.headline)
                        Text("$\(product.price, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Products")
        .task {
            await viewModel.loadProducts()
        }
    }
}


