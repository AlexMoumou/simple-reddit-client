//
//  GetSubredditListings.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 15/02/23.
//

import Foundation
import Combine

protocol IGetSubredditListingsUC {
    func execute(subName: String, after: String?) -> AnyPublisher<ListingState, Error>
}

final class GetSubredditListingsUC: IGetSubredditListingsUC {
    private let repo: IListingsRepo
    
    init(listingsRepo: IListingsRepo) {
        self.repo = listingsRepo
    }

    func execute(subName: String, after: String?) -> AnyPublisher<ListingState, Error> {
        return repo.getPosts(context: .Subreddit(subName, .best), after: after)
    }
}
