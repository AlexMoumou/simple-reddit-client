//
//  ListingsRepo.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 28/9/22.
//

import Foundation
import Combine

final class ListingsRepo {

    private let restClient: IRestClient
        
    init(restClient: IRestClient) {
        self.restClient = restClient
    }
}

extension ListingsRepo: IListingsRepo {
    func getBestPosts(after: String?) -> AnyPublisher<HomeListingState, Error> {
        restClient.get(RedditApiEndpoint.best(after ?? "")).map { (response: ListingDTO) in
            HomeListingState(info: Info(before: response.data.before, after: response.data.after), posts: response.data.posts.map { $0.mapToDomain() })
        }.eraseToAnyPublisher()
    }
    
    func findSubreddits(after: String?, term: String) -> AnyPublisher<SearchState, Error> {
        restClient.get(RedditApiEndpoint.findSubreddits(term, after ?? "")).map { (response: SubredditsSearchDTO) in
            SearchState(info: Info(before: response.data.before, after: response.data.after), subreddits: response.data.subreddits.map { $0.mapToDomain() })
        }.eraseToAnyPublisher()
    }
}
