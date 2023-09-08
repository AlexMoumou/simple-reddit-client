//
//  RestClientErrors.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 24/7/22.
//

import Foundation

/// Client Errors
enum RestClientErrors: Error {
    case requestFailedWith(error: Error)
    case requestFailed(code: Int)
    case noDataReceived
    case jsonDecode(error: Error)
}
