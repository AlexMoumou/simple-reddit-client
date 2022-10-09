//
//  RestClientErrors.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 24/7/22.
//

import Foundation

enum RestClientErrors: Error {
    case requestFailed(error: Error)
    case requestFailed(code: Int)
    case noDataReceived
    case jsonDecode(error: Error)
}
