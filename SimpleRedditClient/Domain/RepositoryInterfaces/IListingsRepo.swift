//
//  IListingsRepo.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 28/9/22.
//

import Foundation
import Combine

protocol IListingsRepo {
    func getBestPosts(after: String?) -> AnyPublisher<HomeListingState, Error>
}
