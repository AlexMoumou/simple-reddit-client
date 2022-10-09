//
//  Post.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 2/8/22.
//

import Foundation

struct PostDTO: Identifiable, Equatable {
    var id: String
    var title: String
    var author: String
    var url: String
    var thumbnail: String
    var subredditNamePrefixed: String
}

// MARK: - Decodable
extension PostDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case url
        case thumbnail
        case subredditNamePrefixed = "subreddit_name_prefixed"
        
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        id = try dataContainer.decode(String.self, forKey: .id)
        title = try dataContainer.decode(String.self, forKey: .title)
        author = try dataContainer.decode(String.self, forKey: .author)
        url = try dataContainer.decode(String.self, forKey: .url)
        thumbnail = try dataContainer.decode(String.self, forKey: .thumbnail)
        subredditNamePrefixed = try dataContainer.decode(String.self, forKey: .subredditNamePrefixed)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

extension PostDTO {
    func mapToDomain() -> Post {
        Post(id: id, title: title, author: author, url: url, thumbnail: thumbnail, subredditNamePrefixed: subredditNamePrefixed)
    }
}
