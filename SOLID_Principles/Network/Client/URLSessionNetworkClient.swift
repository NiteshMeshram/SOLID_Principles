//
//  URLSessionNetworkClient.swift
//  SOLID_Principles
//
//  Created by NiteshMeshram on 8/20/25.
//

/*
✅ Now you’re SOLID:

S: Endpoint only describes endpoint details.

O: New endpoints = new Endpoint objects, no need to modify core.

L: Works fine with any subclass of NetworkClientProtocol.

I: Separated protocols for client vs service.

D: High-level services depend on abstractions, not concrete URLSession.
 
 */
import Foundation

public final class URLSessionNetworkClient: NetworkClientProtocol {
    private let baseURL: URL
    private let session: URLSession

    public init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    public func send<T: Decodable & Sendable>(_ request: NetworkRequest<T>) async throws -> NetworkResponse<T> {
        let urlRequest = URLRequest(baseURL: baseURL, endpoint: request.endpoint)
        
        print("URLSessionNetworkClient : \(urlRequest)")

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: urlRequest)
        } catch let urlError as URLError {
            throw NetworkError.transport(urlError)
        } catch {
            throw NetworkError.transport(URLError(.unknown))
        }

        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200..<300).contains(http.statusCode) else {
            throw NetworkError.unacceptableStatus(code: http.statusCode, data: data)
        }

//        do {
//            let decoded = try JSONDecoder().decode(T.self, from: data)
//            return NetworkResponse(value: decoded, response: http)
//        } catch {
//            throw NetworkError.decoding(error)
//        }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return NetworkResponse(value: decoded, response: http)
        } catch {
            print("Decoding error:", error)
            print("Raw JSON:", String(data: data, encoding: .utf8) ?? "nil")
            throw NetworkError.decoding(error)
        }

    }
}




