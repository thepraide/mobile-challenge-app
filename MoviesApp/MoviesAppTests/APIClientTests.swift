//
//  APIClientTests.swift
//  MoviesAppTests
//
//  Created by Ricardo Hernandez on 13/07/24.
//

import XCTest
@testable import MoviesApp

protocol APIClient {
    @discardableResult
    func perform<T: Decodable>(request: APIRequest) async throws -> T
}

protocol APIRequest {
    var endpoint: String { get }
    var parameters: String { get }
    var headers: [String: String] { get set }
}

protocol TokenProvider {
    func provide() throws -> String
}

enum APIClientErrors: Error {
    case badURL
}

final class RestAPIClient: APIClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func perform<T>(request: APIRequest) async throws -> T where T : Decodable {
        guard let URL = URL(string: request.endpoint) else {
            throw APIClientErrors.badURL
        }
        var urlRequest = URLRequest(url: URL)
        urlRequest.allHTTPHeaderFields = request.headers
        
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

final class APIClientTests: XCTestCase {

    private func makeSUT() -> APIClient {
        return RestAPIClient()
    }
}
