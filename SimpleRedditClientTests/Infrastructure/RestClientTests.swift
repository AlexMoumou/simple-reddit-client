//
//  RestClientTests.swift
//  SimpleRedditClientTests
//
//  Created by Alex Moumoulides on 22/02/23.
//

import XCTest
import Combine

private struct MockModel: Decodable {
    let name: String
}

private struct MockEndpoint: Endpoint {
    var url: URL
}

struct MockSession: NetworkSession {

    let dataTaskResponse: AnyPublisher<URLSession.DataTaskPublisher.Output, URLError>
    
    func providerDataTaskPublisher(for request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLError> {
        return dataTaskResponse.eraseToAnyPublisher()
    }
}

class RestClientTests: XCTestCase {
    
    func test_whenReceivedValidJsonInResponse_shouldDecodeResponseToDecodableObject() {
        //given
        let expectation = self.expectation(description: "Should return correct data")
        let data = "Hello, world!".data(using: .utf8)!
        let response = HTTPURLResponse(url: URL(string: "http://mock.test.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let mockSession = MockSession(dataTaskResponse: Just((data: data, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher())

        //when
        let sut = RestClient(session: mockSession)

        sut.get(MockEndpoint(url: URL(string: "http://mock.test.com")!)).map { (response: String) in
            expectation.fulfill()
        }

        //then
        wait(for: [expectation], timeout: 0.6)
    }
}
