//
//  SearchSubredditsUC.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 02/02/23.
//

import Foundation
import Combine

protocol ISearchSubredditsUC {
    func execute(after: String?, term: String) -> AnyPublisher<SearchState, Error>
}

final class SeachSubredditsUC: ISearchSubredditsUC {
    
    private let repo: IListingsRepo
    
    init(listingsRepo: IListingsRepo) {
        self.repo = listingsRepo
    }

    func execute(after: String?, term: String) -> AnyPublisher<SearchState, Error> {
        return repo.findSubreddits(after: after, term: term)
    }
}
