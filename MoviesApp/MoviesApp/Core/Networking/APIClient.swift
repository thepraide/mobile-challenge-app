//
//  APIClient.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 13/07/24.
//

import Foundation

protocol APIClient {
    func perform<T: Decodable>(request: APIRequest) async throws -> T
}

enum APIClientError: Error {
    case badURL
    case badResponse
    case unauthorized
}

final class RestAPIClient: APIClient {
    
    private let session: URLSession
    private let host: String
    private let decoder: APIDecoder
    
    init(session: URLSession = .shared,
         host: String,
         decoder: APIDecoder = DefaultAPIDecoder()) {
        self.session = session
        self.host = host
        self.decoder = decoder
    }
    
    func perform<T>(request: APIRequest) async throws -> T where T : Decodable {
        guard var components = URLComponents(string: host), !request.endpoint.isEmpty else {
            throw APIClientError.badURL
        }
        components.path = request.endpoint
        components.queryItems = request.parameters.map({ .init(name: $0.key, value: $0.value)})
        
        guard let urlString = components.string, let URL = URL(string: urlString) else {
            throw APIClientError.badURL
        }
        
        var urlRequest = URLRequest(url: URL)
        urlRequest.allHTTPHeaderFields = request.headers
        let (data, response) = try await session.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIClientError.badResponse
        }
        if httpResponse.statusCode == 401 {
            throw APIClientError.unauthorized
        }
        return try decoder.decode(data: data)
    }
    
}

final class AuthRestAPIClient: APIClient {
    
    private let client: APIClient
    private let tokenProvider: TokenProvider
    
    init(client: APIClient, tokenProvider: TokenProvider) {
        self.client = client
        self.tokenProvider = tokenProvider
    }
    
    func perform<T>(request: APIRequest) async throws -> T where T : Decodable {
        let token = try tokenProvider.provide()
        var signedRequest = request
        signedRequest.headers["Auhtorization"] = "Bearer \(token)"
        return try await client.perform(request: signedRequest)
    }
}
