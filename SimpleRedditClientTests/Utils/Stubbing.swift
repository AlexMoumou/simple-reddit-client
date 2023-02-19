//
//  Stubbing.swift
//  SimpleRedditClientTests
//
//  Created by Alex Moumoulides on 19/02/23.
//

import Combine
import Foundation
//@testable import SimpleRedditClient
import XCTest

// MARK: - returnSuccess

/// Returns one success item `S` as function of `AnyPublisher<S, E>` without parameters
func returnSuccess<S, E>(block: @escaping () -> S) -> () -> AnyPublisher<S, E> {
    {
        Just(block()).setFailureType(to: E.self).eraseToAnyPublisher()
    }
}

/// Returns one success item `S` as function of `Future<S, E>` without parameters
func returnSuccess<S, E>(block: @escaping () -> S) -> () -> Future<S, E> {
    {
        Future { promise in
            promise(.success(block()))
        }
    }
}

/// Returns one success item `S` as function of `AnyPublisher<S, E>` but ignores the parameter (1)
func returnSuccess<S, E, P1>(block: @escaping () -> S) -> (P1) -> AnyPublisher<S, E> {
    { _ in
        Just(block()).setFailureType(to: E.self).eraseToAnyPublisher()
    }
}

/// Returns one success item `S` as function of `Future<S, E>` but ignores the parameter (1)
func returnSuccess<S, E, P1>(block: @escaping () -> S) -> (P1) -> Future<S, E> {
    { _ in
        Future { promise in
            promise(.success(block()))
        }
    }
}

// MARK: - returnSuccess as AnyObject

/// Returns one success item `S` as function of `AnyPublisher<AnyObject, E>` without parameters
func returnSuccess<S, E>(block: @escaping () -> S) -> () -> AnyPublisher<AnyObject, E> {
    {
        Just(block() as AnyObject).setFailureType(to: E.self).eraseToAnyPublisher()
    }
}

// MARK: - returnError

/// Returns one error item `E` as function of `AnyPublisher<S, E>` without parameters
func returnError<S, E>(block: @escaping () -> E) -> () -> AnyPublisher<S, E> {
    {
        Fail<S, E>(error: block()).eraseToAnyPublisher()
    }
}

/// Returns one error item `E` as function of `AnyPublisher<S, E>` without parameters
func returnError<S, E>(block: @escaping () -> E) -> () -> Future<S, E> {
    {
        Future { promise in
            promise(.failure(block()))
        }
    }
}

/// Returns one error item `E` as function of `AnyPublisher<S, E>` but ignores the parameter (1)
func returnError<S, E, P1>(block: @escaping () -> E) -> (P1) -> AnyPublisher<S, E> {
    { _ in
        Fail<S, E>(error: block()).eraseToAnyPublisher()
    }
}

/// Returns one error item `E` as function of `AnyPublisher<S, E>` but ignores the parameter (1)
func returnError<S, E, P1>(block: @escaping () -> E) -> (P1) -> Future<S, E> {
    { _ in
        Future { promise in
            promise(.failure(block()))
        }
    }
}
