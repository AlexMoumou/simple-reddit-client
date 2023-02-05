//
//  SubredditDTO.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 04/02/23.
//

import Foundation

struct SubredditDTO: Identifiable, Equatable {
    var id: String
    var title: String
    var name: String
    var display_name_prefixed: String
    var header_img: String?
    var public_description: String
    var description_html: String?
    var over18: Bool = false
}

// MARK: - Decodable
extension SubredditDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case name
        case display_name_prefixed
        case header_img
        case public_description
        case description_html
        case over18
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        id = try dataContainer.decode(String.self, forKey: .id)
        title = try dataContainer.decode(String.self, forKey: .title)
        name = try dataContainer.decode(String.self, forKey: .name)
        display_name_prefixed = try dataContainer.decode(String.self, forKey: .display_name_prefixed)
        header_img = try? dataContainer.decode(String.self, forKey: .header_img)
        public_description = try dataContainer.decode(String.self, forKey: .public_description)
        description_html = try? dataContainer.decode(String.self, forKey: .description_html)
        
        if let nsfw = try? dataContainer.decode(Bool.self, forKey: .over18) {
            over18 = nsfw
        }
    }
    
    func encode(to encoder: Encoder) throws {}
}

extension SubredditDTO {
    func mapToDomain() -> Subreddit {
        Subreddit(id: id, title: title, name: name, display_name_prefixed: display_name_prefixed, header_img: header_img ?? "", public_description: public_description, description_html: description_html ?? "", over18: over18)
    }
}
