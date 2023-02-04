//
//  GetHomeListings.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 4/8/22.
//

import Foundation
import Combine

protocol IGetHomeListingsUC {
    func execute(after: String?) -> AnyPublisher<HomeListingState, Error>
}

final class GetHomeListingsUC: IGetHomeListingsUC {
    private let repo: IListingsRepo
    
    init(listingsRepo: IListingsRepo) {
        self.repo = listingsRepo
    }

    func execute(after: String?) -> AnyPublisher<HomeListingState, Error> {
        return repo.getBestPosts(after: after)
    }
}
