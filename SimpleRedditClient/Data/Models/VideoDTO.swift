//
//  VideoDTO.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 13/10/22.
//

import Foundation

struct VideoDTO: Identifiable, Equatable {
    var id: UUID
    var width: Int
    var height: Int
    var url: String
    var isGif: Bool
}

// MARK: - Decodable
extension VideoDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case url = "hls_url"
        case isGif = "is_gif"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        id = UUID()
        url = try values.decode(String.self, forKey: .url)
        width = try values.decode(Int.self, forKey: .width)
        height = try values.decode(Int.self, forKey: .height)
        isGif = try values.decode(Bool.self, forKey: .isGif)
    }
    
    func encode(to encoder: Encoder) throws {}
}
