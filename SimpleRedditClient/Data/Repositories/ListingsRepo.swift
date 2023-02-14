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
    func getPosts(context: PostContext, after: String?) -> AnyPublisher<ListingState, Error> {
        var endpoint: RedditApiEndpoint? = nil
        
        switch context {
        case .Home(let sort):
            endpoint = RedditApiEndpoint.homePosts(sort.description, after ?? "")
        case .Subreddit(let subName, let sort):
            endpoint = RedditApiEndpoint.subredditPosts(subName, sort.description, after ?? "")
        }
        
        return restClient.get(endpoint!).map { (response: ListingDTO) in
            ListingState(info: Info(before: response.data.before, after: response.data.after), posts: response.data.posts.map { $0.mapToDomain() })
        }.eraseToAnyPublisher()
    }
    
    func findSubreddits(after: String?, term: String) -> AnyPublisher<SearchState, Error> {
        restClient.get(RedditApiEndpoint.findSubreddits(term, after ?? "")).map { (response: SubredditsSearchDTO) in
            SearchState(info: Info(before: response.data.before, after: response.data.after), subreddits: response.data.subreddits.map { $0.mapToDomain() })
        }.eraseToAnyPublisher()
    }
}
