//
//  Category.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import Foundation

/// Represents a category entity from the API.
public struct Category: Codable, Identifiable, Sendable, Equatable {
    public let id: Int
    public let name: String
    public let description: String?
    
    public init(id: Int, name: String, description: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
    }
}
