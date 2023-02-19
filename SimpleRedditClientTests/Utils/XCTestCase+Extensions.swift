//
//  XCTestCase+Extensions.swift
//  SimpleRedditClientTests
//
//  Created by Alex Moumoulides on 19/02/23.
//

import Combine
import Foundation
import XCTest

/*
 * COPY - PASTED
 */

extension XCTestCase {
    /// Waits for the successful completion of `publisher`.
    func waitForSuccessfulCompletion<T: Publisher>(of publisher: T,
                                                   timeout: TimeInterval = 2,
                                                   file: StaticString = #file,
                                                   line: UInt = #line)
    {
        let exp = expectation(description: "waiting for successful completion of " + String(describing: publisher))

        let cancellable = publisher
            .sink(receiveCompletion: { completion in
                if case .finished = completion {
                    exp.fulfill()
                }
            }, receiveValue: { _ in })
        waitForExpectation(exp: exp, timeout: timeout, file: file, line: line)

        // we just have to keep the cancellable around so our publisher
        // is not cancelled when the AnyCancellable gets deinited
        XCTAssertNotNil(cancellable)
    }
    
    /// Waits for the **un**successful completion of `publisher`.
    ///
    /// - Parameter errorCheck: Optionally checks if it failed with a specific error.
    func waitForFailureCompletion<T: Publisher>(of publisher: T,
                                                timeout: TimeInterval = 2,
                                                file: StaticString = #file,
                                                line: UInt = #line,
                                                errorCheck: ((T.Failure) -> Bool)? = nil) {
        let exp = expectation(description: "waiting for un-successful completion of "
            + String(describing: publisher))
        exp.assertForOverFulfill = false
        let cancellable = publisher
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    if let test = errorCheck {
                        if test(error) {
                            exp.fulfill()
                        }
                    } else {
                        exp.fulfill()
                    }
                }
            }, receiveValue: { _ in })
        waitForExpectation(exp: exp, timeout: timeout, file: file, line: line)

        // we just have to keep the cancellable around so our publisher
        // is not cancelled when the AnyCancellable gets deinited
        XCTAssertNotNil(cancellable)
    }

    /// Waits for a specific value published by the `publisher`.
    func waitForValue<T: Publisher>(of publisher: T,
                                    timeout: TimeInterval = 2,
                                    file: StaticString = #file,
                                    line: UInt = #line,
                                    value: T.Output) where T.Output: Equatable
    {
        let exp = expectation(description: "waiting for successful value check ")
        exp.assertForOverFulfill = false

        let cancellable = publisher
            .sink(receiveCompletion: { _ in }, receiveValue: { receiveValue in
                if receiveValue == value {
                    exp.fulfill()
                }
            })

        waitForExpectation(exp: exp, timeout: timeout, file: file, line: line)

        // we just have to keep the cancellable around so our publisher
        // is not cancelled when the AnyCancellable gets deinited
        XCTAssertNotNil(cancellable, file: file, line: line)
    }

    private func waitForExpectation(exp: XCTestExpectation,
                                    timeout: TimeInterval = 2,
                                    enforceOrder: Bool = false,
                                    file: StaticString = #file,
                                    line: UInt = #line)
    {
        let result = XCTWaiter.wait(for: [exp], timeout: timeout, enforceOrder: enforceOrder)
        switch result {
        case .timedOut:
            XCTFail("Timed out waiting for correct value", file: file, line: line)
        default:
            break
        }
    }
}
