//
//  SearchSubredditsUC.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 02/02/23.
//

import Foundation
import Combine

protocol ISearchSubreddits {
    func execute(after: String) -> AnyPublisher<SearchState, Error>
}


