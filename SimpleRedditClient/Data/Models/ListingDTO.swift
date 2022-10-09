//
//  Listing.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 3/8/22.
//

import Foundation

// MARK: - Listing
struct ListingDTO: Decodable {
    let kind: String
    let data: ListingData
    
    enum CodingKeys: String, CodingKey {
        case kind
        case data
    }
}

// MARK: - ListingData
struct ListingData: Decodable {
    let before: String?
    let after: String
    let posts: [PostDTO]
    
    enum CodingKeys: String, CodingKey {
        case before
        case after
        case posts = "children"
    }
    
}
