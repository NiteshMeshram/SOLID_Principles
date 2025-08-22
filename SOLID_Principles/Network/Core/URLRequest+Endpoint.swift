//
//  URLRequest+Endpoint.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

import Foundation

public extension URLRequest {
    init<Response>(baseURL: URL, endpoint: Endpoint<Response>) {
        var components = URLComponents(
            url: baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        )!
        components.queryItems = endpoint.queryItems.isEmpty ? nil : endpoint.queryItems

        self.init(url: components.url!)
        self.httpMethod = endpoint.method.rawValue
        self.allHTTPHeaderFields = endpoint.headers
        self.httpBody = endpoint.body
    }
}

