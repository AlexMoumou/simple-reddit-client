//
//  SearchSubredditViewModelTests.swift
//  SimpleRedditClientTests
//
//  Created by Alex Moumoulides on 20/02/23.
//

import Foundation
import XCTest
import Combine

class ISearchSubredditsUCMock: ISearchSubredditsUC {
    
    var subsListState: SearchState?
    
    func execute(after: String?, term: String) -> AnyPublisher<SearchState, Error> {
        guard let state = subsListState else {
          fatalError("Result is nil")
        }
        
        return Just(state)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}

class SearchSubredditViewModelTests: XCTestCase {
    var getSubsUC: ISearchSubredditsUCMock?
    var sut: SearchSubredditsViewModel?
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        sut = nil
        getSubsUC = nil
        super.tearDown()
    }
    
    func testVMGetsCorrectDataAfterLoad() throws {
        //Given
        getSubsUC = ISearchSubredditsUCMock()
        getSubsUC?.subsListState = SearchState(info: Info(before: nil, after: nil), subreddits: [Subreddit.example(), Subreddit.example().copyWith(id: "id")])
        
        sut = SearchSubredditsViewModel(getSubreddits: getSubsUC!)
        
        //When
        sut?.send(action: .load("test"))
        
        //Then
        waitForValue(of: sut!.$subredditsList, value: [Subreddit.example(), Subreddit.example().copyWith(id: "id")])
        waitForValue(of: sut!.$after, value: nil)
    }
    
    func testSubredditsListIsReplacedWhenTermIsDifferentFromPrevious() throws {
        //Given
        getSubsUC = ISearchSubredditsUCMock()
        getSubsUC?.subsListState = SearchState(info: Info(before: nil, after: "after"), subreddits: [Subreddit.example().copyWith(id: "id")])
        
        sut = SearchSubredditsViewModel(getSubreddits: getSubsUC!)
        sut?.subredditsList = [Subreddit.example()]
        sut?.term = "test1"
        
        //When
        sut?.send(action: .load("test2"))
        
        //Then
        waitForValue(of: sut!.$subredditsList, value: [Subreddit.example().copyWith(id: "id")])
        waitForValue(of: sut!.$after, value: "after")
    }
    
    func testSubredditsListResultsAreAddedWhenTermIsSameAsPrevious() throws {
        //Given
        getSubsUC = ISearchSubredditsUCMock()
        getSubsUC?.subsListState = SearchState(info: Info(before: nil, after: "after"), subreddits: [Subreddit.example().copyWith(id: "id")])
        
        sut = SearchSubredditsViewModel(getSubreddits: getSubsUC!)
        sut?.subredditsList = [Subreddit.example()]
        sut?.term = "test1"
        
        //When
        sut?.send(action: .load("test1"))
        
        //Then
        waitForValue(of: sut!.$subredditsList, value: [Subreddit.example(), Subreddit.example().copyWith(id: "id")])
        waitForValue(of: sut!.$after, value: "after")
    }
}
