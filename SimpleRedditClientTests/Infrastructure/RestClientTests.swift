//
//  RestClientTest.swift
//  AgendaAppTests
//
//  Created by Alex Moumoulidis on 7/9/23.
//

import XCTest
import Combine

private struct MockModel: Decodable {
    let name: String
}

private struct MockEndpoint: Endpoint {
    var url: URL
}

struct MockDTO: Decodable {
    let data: String
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct MockAPIProvider: APIProvider {
    
    let dataTaskResponse: AnyPublisher<APIResponse, URLError>
    
    func apiResponse(for request: URLRequest) -> AnyPublisher<APIResponse, URLError> {
        return dataTaskResponse
    }
}

class RestClientTests: XCTestCase {
    
    func test_get_method_whenReceivedValidJsonInResponse_shouldDecodeResponseToDecodableObject() async {
        //given
        let expectation = self.expectation(description: "Should return correct data")
        let data =  try? JSONSerialization.data(withJSONObject: ["data": "test"], options: .prettyPrinted)
        let response = HTTPURLResponse(url: URL(string: "http://mock.test.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let mockSession = MockAPIProvider(dataTaskResponse: Just((data: data!, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher())
        
        //when
        let sut = RestClient(session: mockSession)
        
        sut.get(MockEndpoint(url: URL(string: "http://mock.test.com")!))
            .map { (response: MockDTO) in
                response
            }
            .sink { _ in } receiveValue: { value in
                expectation.fulfill()
            }
            .cancel()
        
        //then
        await fulfillment(of: [expectation], timeout: 0.4)
    }
    
    func test_get_method_whenReceivedInvalidJsonInResponse_shouldThrowError() async {
        //given
        let expectation = self.expectation(description: "Should return correct data")
        let data =  try? JSONSerialization.data(withJSONObject: ["dat": "test"], options: .prettyPrinted)
        let response = HTTPURLResponse(url: URL(string: "http://mock.test.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let mockSession = MockAPIProvider(dataTaskResponse: Just((
            data: data!, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher())
        
        //when
        let sut = RestClient(session: mockSession)
        
        sut.get(MockEndpoint(url: URL(string: "http://mock.test.com")!))
            .map { (response: MockDTO) in
                response
            }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    switch error as! RestClientErrors {
                        case .jsonDecode(let message):
                            print(message)
                            expectation.fulfill()
                        default:
                            break
                    }
                    print(error)
                }
            } receiveValue: { _ in }
            .cancel()
        
        //then
        await fulfillment(of: [expectation], timeout: 0.4)
    }
    
    func test_get_method_whenReceivedResponseCodeDifferentThan200_shouldThrowError() async {
        //given
        let expectation = self.expectation(description: "Should return correct data")
        let data =  try? JSONSerialization.data(withJSONObject: ["data": "test"], options: .prettyPrinted)
        let response = HTTPURLResponse(url: URL(string: "http://mock.test.com")!, statusCode: 401, httpVersion: "HTTP/1.1", headerFields: nil)!
        let mockSession = MockAPIProvider(dataTaskResponse: Just((data: data!, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher())
        
        //when
        let sut = RestClient(session: mockSession)
        
        
        sut.get(MockEndpoint(url: URL(string: "http://mock.test.com")!))
            .map { (response: MockDTO) in
                response
            }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    switch error as! RestClientErrors {
                        case .requestFailed(let code):
                            print("requestFail with code: \(code)")
                            expectation.fulfill()
                        default:
                            break
                    }
                    print(error)
                }
            } receiveValue: { value in }
            .cancel()
        
        //then
        await fulfillment(of: [expectation], timeout: 0.4)
    }
    
    func test_get_method_whenNoDataReturned_shouldThrowError() async {
        //given
        let expectation = self.expectation(description: "Should return correct data")
        let data = "".data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "http://mock.test.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let mockSession = MockAPIProvider(dataTaskResponse: Just((data: data!, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher())
        
        //when
        let sut = RestClient(session: mockSession)
        
        sut.get(MockEndpoint(url: URL(string: "mock.testom")!))
            .map { (response: MockDTO?) in
                response
            }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    switch error as! RestClientErrors {
                        case .noDataReceived:
                            print("noDataReceived")
                            expectation.fulfill()
                        default:
                            break
                    }
                    print(error)
                }
            } receiveValue: { value in }
            .cancel()
        
        //then
        await fulfillment(of: [expectation], timeout: 0.4)
    }
    
    func test_post_method_whenReceivedValidJsonInResponse_shouldDecodeResponseToDecodableObject() async {
        //given
        let expectation = self.expectation(description: "Should return correct data")
        let data =  try? JSONSerialization.data(withJSONObject: ["data": "test"], options: .prettyPrinted)
        let response = HTTPURLResponse(url: URL(string: "http://mock.test.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let mockSession = MockAPIProvider(dataTaskResponse: Just((data: data!, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher())
        
        //when
        let sut = RestClient(session: mockSession)
        
        sut.post(MockEndpoint(url: URL(string: "http://mock.test.com")!), using: data)
            .map { (response: MockDTO?) in
                response
            }
            .sink { _ in } receiveValue: { value in
                expectation.fulfill()
            }
            .cancel()
        
        //then
        await fulfillment(of: [expectation], timeout: 0.4)
    }
    
    func test_post_method_whenReceivedInvalidJsonInResponse_shouldThrowError() async {
        //given
        let expectation = self.expectation(description: "Should return correct data")
        let data =  try? JSONSerialization.data(withJSONObject: ["dat": "test"], options: .prettyPrinted)
        let response = HTTPURLResponse(url: URL(string: "http://mock.test.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let mockSession = MockAPIProvider(dataTaskResponse: Just((
            data: data!, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher())
        
        //when
        let sut = RestClient(session: mockSession)
        
        sut.post(MockEndpoint(url: URL(string: "http://mock.test.com")!), using: data)
            .map { (response: MockDTO?) in
                response
            }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    switch error as! RestClientErrors {
                        case .jsonDecode(let message):
                            print(message)
                            expectation.fulfill()
                        default:
                            break
                    }
                    print(error)
                }
            } receiveValue: { _ in }
            .cancel()
        
        //then
        await fulfillment(of: [expectation], timeout: 0.4)
    }
    
    func test_post_method_whenReceivedResponseCodeDifferentThan200_shouldThrowError() async {
        //given
        let expectation = self.expectation(description: "Should return correct data")
        let data =  try? JSONSerialization.data(withJSONObject: ["data": "test"], options: .prettyPrinted)
        let response = HTTPURLResponse(url: URL(string: "http://mock.test.com")!, statusCode: 401, httpVersion: "HTTP/1.1", headerFields: nil)!
        let mockSession = MockAPIProvider(dataTaskResponse: Just((data: data!, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher())
        
        //when
        let sut = RestClient(session: mockSession)
        
        
        sut.post(MockEndpoint(url: URL(string: "http://mock.test.com")!), using: data)
            .map { (response: MockDTO?) in
                response
            }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    switch error as! RestClientErrors {
                        case .requestFailed(let code):
                            print("requestFail with code: \(code)")
                            expectation.fulfill()
                        default:
                            break
                    }
                    print(error)
                }
            } receiveValue: { value in }
            .cancel()
        
        //then
        await fulfillment(of: [expectation], timeout: 0.4)
    }
    
    func test_post_method_whenNoDataReturned_shouldReturnWithNilObject() async {
        //given
        let expectation = self.expectation(description: "Should return correct data")
        let data = "".data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "http://mock.test.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let mockSession = MockAPIProvider(dataTaskResponse: Just((data: data!, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher())
        
        //when
        let sut = RestClient(session: mockSession)
        
        sut.post(MockEndpoint(url: URL(string: "mock.testom")!), using: "")
            .map { (response: MockDTO?) in
                response
            }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    switch error as! RestClientErrors {
                        default:
                            break
                    }
                    print(error)
                }
            } receiveValue: { value in
                expectation.fulfill()
            }
            .cancel()
        
        //then
        await fulfillment(of: [expectation], timeout: 0.4)
    }
    
    func test_post_method_whenRequestFails_shouldReturnFailedWithError() async {
        //given
        let expectation = self.expectation(description: "Should return correct data")
        let data = "".data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "http://mock.test.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let mockSession = MockAPIProvider(dataTaskResponse: Fail<URLSession.DataTaskPublisher.Output, URLError>(outputType: (data: Data, response: URLResponse).self, failure: URLError(.badURL)).eraseToAnyPublisher())
        
        //when
        let sut = RestClient(session: mockSession)
        
        sut.post(MockEndpoint(url: URL(string: "mock.testom")!), using: "")
            .map { (response: MockDTO?) in
                response
            }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    switch error as! RestClientErrors {
                    case .requestFailedWith(error: let error):
                        print(error)
                        expectation.fulfill()
                        default:
                            break
                    }
                    print(error)
                }
            } receiveValue: { value in }
            .cancel()
        
        //then
        await fulfillment(of: [expectation], timeout: 0.4)
    }
    
    func test_post_method_whenBuildRequestFails_shouldReturnJsonDecodeError() async {
        //given
        let expectation = self.expectation(description: "Should return correct data")
        let data = "".data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "http://mock.test.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let mockSession = MockAPIProvider(dataTaskResponse: Just((data: data!, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher())
        
        //when
        let sut = RestClient(session: mockSession)
        
        //Encoding an infinite float number should fail. We do this to showcase that failing json encoding when building a request is handled.
        sut.post(MockEndpoint(url: URL(string: "mock.testom")!), using: Float.infinity)
            .map { (response: MockDTO?) in
                response
            }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    switch error as! RestClientErrors {
                        case .jsonDecode(error: let error):
                            print(error)
                            expectation.fulfill()
                        default:
                            break
                    }
                    print(error)
                }
            } receiveValue: { value in }
            .cancel()
        
        //then
        await fulfillment(of: [expectation], timeout: 0.4)
    }
}
