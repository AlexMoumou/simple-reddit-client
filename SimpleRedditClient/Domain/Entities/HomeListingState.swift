//
//  HomeListingState.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 28/9/22.
//

import Foundation

struct HomeListingState: Equatable {
    let info: Info
    let posts: [Post]
}

// MARK: - Info
struct Info: Equatable {
    let before: String?
    let after: String
}
