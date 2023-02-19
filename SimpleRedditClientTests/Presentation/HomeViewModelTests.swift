//
//  HomeViewModelTests.swift
//  SimpleRedditClientTests
//
//  Created by Alex Moumoulides on 19/02/23.
//

import Foundation
import Combine
import XCTest

class IGetHomeListingsUCMock: IGetHomeListingsUC {
    
    var postListState: ListingState?
    
    func execute(after: String?) -> AnyPublisher<ListingState, Error> {
        guard let state = postListState else {
          fatalError("Result is nil")
        }
        
        return Just(state)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}

class HomeViewModelTests: XCTestCase {
    var getHomeListingsUC: IGetHomeListingsUCMock?
    var sut: HomeViewModel?
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        sut = nil
        getHomeListingsUC = nil
        super.tearDown()
    }
    
    func testVMGetsCorrectData() async throws {
        getHomeListingsUC = IGetHomeListingsUCMock()
        
        getHomeListingsUC?.postListState = ListingState(info: Info(before: nil, after: nil), posts: [Post.example(), Post.example().copyWith(id: "2")])
        
        sut = HomeViewModel(getHomeListings: getHomeListingsUC!)
        
        waitForValue(of: sut!.$postsList, value: [Post.example(), Post.example().copyWith(id:"2")])
        waitForValue(of: sut!.$after, value: nil)
    }
}
