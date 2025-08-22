//
//  Product.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

public struct Product: Codable, Sendable, Equatable {
    public let id: Int
    public let name: String        // <- keep your app’s naming
    public let price: Double
    public let description: String?
    public let images: [String]?
    public let category: Category?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"        // <- map API "title" -> app "name"
        case price, description, images, category
    }

    public struct Category: Codable, Sendable, Equatable {
        public let id: Int
        public let name: String
        public let image: String?
    }
}
