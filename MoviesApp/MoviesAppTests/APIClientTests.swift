//
//  APIClientTests.swift
//  MoviesAppTests
//
//  Created by Ricardo Hernandez on 13/07/24.
//

import XCTest
@testable import MoviesApp

final class APIClientTests: XCTestCase {

    func test_emptyEndpoint_throws_badURLError() async {
        let request = DummyRequest(endpoint: "", parameters: [:], headers: [:])
        let sut = makeSUT()
        do {
            let _: Data = try await sut.perform(request: request)
        } catch {
            XCTAssertEqual(error as! APIClientError, APIClientError.badURL)
        }
    }
    
    func test_differentHTTPURLResponse_throws_badResponseError() async {
        let request = DummyRequest(endpoint: "/api", parameters: ["param1": "value"], headers: ["header1": "value"])
        let sut = makeSUT()
        MockURLProtocol.responseStub = {
            return (URLResponse(), Data())
        }
        do {
            let _: Data = try await sut.perform(request: request)
        } catch {
            XCTAssertEqual(error as! APIClientError, APIClientError.badResponse)
        }
    }
    
    
    func test_requestValues_areSetCorrectly() async throws {
        let request = DummyRequest(endpoint: "/api", parameters: ["param1": "value", "param2": "value"], headers: ["header1": "value"])
        let sut = makeSUT()
        let data = try JSONEncoder().encode("value")
        MockURLProtocol.responseStub = {
            return (HTTPURLResponse(url: URL(string: "URL")!, statusCode: 200, httpVersion: nil, headerFields: nil)!,
                    data)
        }
        
        let _: String = try await sut.perform(request: request)
        let query = request.parameters.map { "\($0.key)=\($0.value)"}.joined(separator: "&")
        XCTAssertEqual(request.endpoint, MockURLProtocol.requestSpy?.url?.relativePath)
        XCTAssertEqual(request.headers, MockURLProtocol.requestSpy?.allHTTPHeaderFields)
        XCTAssertEqual(query, MockURLProtocol.requestSpy?.url?.query())
    }
    
    func test_statusCode401_throws_unauthorizedError() async throws {
        let request = DummyRequest(endpoint: "/api", parameters: [:], headers: [:])
        let sut = makeSUT()
        MockURLProtocol.responseStub = {
            return (HTTPURLResponse(url: URL(string: "URL")!, statusCode: 401, httpVersion: nil, headerFields: nil)!,
                    Data())
        }
        
        do {
            let _: Data = try await sut.perform(request: request)
        } catch {
            XCTAssertEqual(error as! APIClientError, APIClientError.unauthorized)
        }
        
    }
    
    private func makeSUT() -> APIClient {
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return RestAPIClient(session: URLSession(configuration: configuration), host: "https://host.com")
    }
}

struct DummyRequest: APIRequest {
    let endpoint: String
    let parameters: [String : String]
    var headers: [String : String]
}

final class MockURLProtocol: URLProtocol {
    
    static var errorStub: Error?
    static var responseStub: (() -> (URLResponse, Data))?
    static var requestSpy: URLRequest?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        requestSpy = request
        return request
    }
    
    override func startLoading() {
        if let error = Self.errorStub {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        guard let stub = MockURLProtocol.responseStub else {
            assertionFailure("Missing responseStub")
            return
        }
        let (response, data) = stub()
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: data)
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
