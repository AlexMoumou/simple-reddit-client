//
//  RestClient.swift
//  AgendaApp
//
//  Created by Alex Moumoulidis on 7/9/23.
//

import Foundation
import Combine

/// Provides access to the REST Backend
protocol IRestClient {
    /// Retrieves a JSON resource and decodes it
    func get<T: Decodable, E: Endpoint>(_ endpoint: E) -> AnyPublisher<T, Error>

    /// Creates some resource by sending a JSON body and returning empty response
    func post<S: Encodable, T: Decodable, E: Endpoint>(_ endpoint: E, using body: S)
        -> AnyPublisher<T?, Error>
}

protocol APIProvider {
    typealias APIResponse = URLSession.DataTaskPublisher.Output
    func apiResponse(for request: URLRequest) -> AnyPublisher<APIResponse, URLError>
}

extension URLSession: APIProvider {
    func apiResponse(for request: URLRequest) -> AnyPublisher<APIResponse, URLError> {
        return dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}

// MARK: - Implementation

class RestClient: IRestClient {
    private let session: APIProvider

    init(session: APIProvider) {
        self.session = session
    }

    func get<T, E>(_ endpoint: E) -> AnyPublisher<T, Error> where T: Decodable, E: Endpoint {
        startRequest(for: endpoint, method: "GET", jsonBody: nil as String?)
            .tryMap {
                try $0.parseJson()
            }
            .catch { error -> AnyPublisher<T, Error> in
                return Fail<T, Error>(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func post<T, S, E>(_ endpoint: E, using body: S) -> AnyPublisher<T?, Error> where T: Decodable, E: Endpoint, S: Encodable {
        startRequest(for: endpoint, method: "POST", jsonBody: body)
            .tryMap {
                try $0.parseJson()
            }
            .catch { error -> AnyPublisher<T?, Error> in
                switch error {
                case RestClientErrors.noDataReceived:
                    // API's Post request doesn't return data back even with code 200
                    return Just(nil).setFailureType(to: Error.self).eraseToAnyPublisher()
                default:
                    return Fail<T?, Error>(error: error).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    private func startRequest<T: Encodable, S: Endpoint>(for endpoint: S,
                                                         method: String,
                                                         jsonBody: T? = nil) -> AnyPublisher<InterimRestResponse, Error> {
        var request: URLRequest

        do {
            request = try buildRequest(endpoint: endpoint, method: method, jsonBody: jsonBody)
        } catch {
            print("Failed to create request: \(String(describing: error))")
            return Fail(error: error).eraseToAnyPublisher()
        }

        print("Starting \(method) request for \(String(describing: request))")

        return session.apiResponse(for: request)
            .mapError { (error: Error) -> Error in
                print("Request failed: \(String(describing: error))")
                return RestClientErrors.requestFailedWith(error: error)
            }
            // we got a response, lets see what kind of response
            .tryMap { (data: Data, response: URLResponse) in
                let response = response as! HTTPURLResponse
                print("Got response with status code \(response.statusCode) and \(data.count) bytes of data")

                if response.statusCode != 200 {
                    throw RestClientErrors.requestFailed(code: response.statusCode)
                }
                return InterimRestResponse(data: data, response: response)
            }.eraseToAnyPublisher()
    }

    private func buildRequest<T: Encodable, S: Endpoint>(endpoint: S,
                                                         method: String,
                                                         jsonBody: T?) throws -> URLRequest {
        
        var request = URLRequest(url: endpoint.url, timeoutInterval: 10)
        request.httpMethod = method
        
        /// Set the Authorization header value using the access token.
//        request.setValue("bearer " + "token goes here", forHTTPHeaderField: "Authorization")
        
        // if we got some data, we encode as JSON and put it in the request
        if let body = jsonBody {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                throw RestClientErrors.jsonDecode(error: error)
            }
        }
        return request
    }

    struct InterimRestResponse {
        let data: Data
        let response: HTTPURLResponse

        func parseJson<T: Decodable>() throws -> T {
            if data.isEmpty {
                throw RestClientErrors.noDataReceived
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("Failed to decode JSON: \(error)", String(describing: error))
                throw RestClientErrors.jsonDecode(error: error)
            }
        }
    }
}
