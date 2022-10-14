//
//  Post.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 28/9/22.
//

import Foundation

struct Post: Equatable, Identifiable {
    let id: String
    let title: String
    var author: String
    var url: String
    var thumbnail: String
    var selftext: String?
    var subredditNamePrefixed: String
    var isVideo: Bool
    var videoURL: String
}

extension Post {
    static func example() -> Post {
        return Post(id: "abcde",
                    title: "Jupiter rising with four of its moons, photographed over a barn 2.5km away at a focal length of 2350mm",
                    author: "Muld3r",
                    url: "http://cdn.esawebb.org/archives/images/screen/jupiter-auroras1.jpg",
                    thumbnail: "https://upload.wikimedia.org/wikipedia/commons/2/2b/Jupiter_and_its_shrunken_Great_Red_Spot.jpg",
                    selftext: nil,
                    subredditNamePrefixed: "r/interestingasfuck",
                    isVideo: false,
                    videoURL: ""
        )
    }
    
    func copyWith(
        id: String? = nil,
        title: String? = nil,
        author: String? = nil,
        url: String? = nil,
        thumbnail: String? = nil,
        selftext: String? = nil,
        subredditNamePrefixed: String? = nil,
        isVideo: Bool? = nil,
        videoURL: String? = nil
    ) -> Post {
        return Post(id: id ?? self.id,
                    title: title ?? self.title,
                    author: author ?? self.author,
                    url: url ?? self.url,
                    thumbnail: thumbnail ?? self.thumbnail,
                    selftext: selftext ?? self.selftext,
                    subredditNamePrefixed: subredditNamePrefixed ?? self.subredditNamePrefixed,
                    isVideo: isVideo ?? self.isVideo,
                    videoURL: videoURL ?? self.videoURL
        )
    }
}
