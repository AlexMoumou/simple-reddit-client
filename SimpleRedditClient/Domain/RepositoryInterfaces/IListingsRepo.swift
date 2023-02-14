//
//  IListingsRepo.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 28/9/22.
//

import Foundation
import Combine

protocol IListingsRepo {
    func findSubreddits(after: String?, term: String) -> AnyPublisher<SearchState, Error>
    func getPosts(context: PostContext, after: String?) -> AnyPublisher<ListingState, Error>
}

enum PostContext {
    case Home(SortType)
    case Subreddit(String, SortType)
    //TODO: Possible implementation for posts in search
    //case Search
}

enum SortType: CustomStringConvertible {
    case best
    case top
    case new
    case rising
    case controversial
    
    var description : String {
        switch self {
            case .best: return "best"
            case .top: return "top"
            case .new: return "new"
            case .rising: return "rising"
            case .controversial: return "new"
        }
    }
}
