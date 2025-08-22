//
//  SOLID_PrinciplesApp.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import SwiftUI
// https://api.escuelajs.co/api/v1/products
@main
struct SOLID_PrinciplesApp: App {
    var body: some Scene {
        WindowGroup {
                   let baseURL = URL(string: "https://api.escuelajs.co/api/v1")! // Platzi FakeAPI
                   let client = URLSessionNetworkClient(baseURL: baseURL)
                   let service = DefaultProductService(client: client)
                   let repository = ProductRepository(service: service)
                   let viewModel = ProductViewModel(repository: repository)

                   ProductListView(viewModel: viewModel)
               }
    }
}
