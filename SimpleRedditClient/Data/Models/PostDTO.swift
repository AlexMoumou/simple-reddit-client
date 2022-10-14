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
    var selftext: String?
    var subredditNamePrefixed: String
    var isVideo: Bool
    var video: VideoDTO?
}

// MARK: - Decodable
extension PostDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case url
        case thumbnail
        case selftext
        case subredditNamePrefixed = "subreddit_name_prefixed"
        case isVideo = "is_video"
        case media
        case data
    }
    
    enum MediaKeys: String, CodingKey {
        
        case video = "reddit_video"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        id = try dataContainer.decode(String.self, forKey: .id)
        title = try dataContainer.decode(String.self, forKey: .title)
        author = try dataContainer.decode(String.self, forKey: .author)
        url = try dataContainer.decode(String.self, forKey: .url)
        thumbnail = try dataContainer.decode(String.self, forKey: .thumbnail)
        selftext = try? dataContainer.decode(String.self, forKey: .selftext)
        subredditNamePrefixed = try dataContainer.decode(String.self, forKey: .subredditNamePrefixed)
        isVideo = try dataContainer.decode(Bool.self, forKey: .isVideo)

        let mediaContainer = try? dataContainer.nestedContainer(keyedBy: MediaKeys.self, forKey: .media)
        
        if mediaContainer != nil {
            video = try? mediaContainer?.decode(VideoDTO.self, forKey: .video)
        }
    }
    
    func encode(to encoder: Encoder) throws {}
}

extension PostDTO {
    func mapToDomain() -> Post {
        Post(id: id, title: title, author: author, url: url, thumbnail: thumbnail, selftext: selftext, subredditNamePrefixed: subredditNamePrefixed, isVideo: isVideo, videoURL: video?.url ?? "")
    }
}
