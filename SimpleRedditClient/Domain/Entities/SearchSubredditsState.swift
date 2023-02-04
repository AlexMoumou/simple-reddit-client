//
//  SearchSubredditsState.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 02/02/23.
//

import Foundation

struct SearchState: Equatable {
    let info: Info
    let subreddits: [Subreddit]
}
