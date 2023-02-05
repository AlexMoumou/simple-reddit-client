//
//  SubredditsSearchDTO.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 04/02/23.
//

import Foundation

// MARK: - Listing
struct SubredditsSearchDTO: Decodable {
    let kind: String
    let data: SubredditsData
    
    enum CodingKeys: String, CodingKey {
        case kind
        case data
    }
}

// MARK: - ListingData
struct SubredditsData: Decodable {
    let before: String?
    let after: String?
    let subreddits: [SubredditDTO]
    
    enum CodingKeys: String, CodingKey {
        case before
        case after
        case subreddits = "children"
    }
    
}
