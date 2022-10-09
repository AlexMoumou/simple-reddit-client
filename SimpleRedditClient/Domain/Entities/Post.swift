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
    var subredditNamePrefixed: String
}

extension Post {
    static func example() -> Post {
        return Post(id: "abcde",
                    title: "Jupiter rising with four of its moons, photographed over a barn 2.5km away at a focal length of 2350mm",
                    author: "Muld3r",
                    url: "http://cdn.esawebb.org/archives/images/screen/jupiter-auroras1.jpg",
                    subredditNamePrefixed: "r/interestingasfuck"
        )
    }
    
    func copyWith(
        id: String? = nil,
        title: String? = nil,
        author: String? = nil,
        url: String? = nil,
        subredditNamePrefixed: String? = nil
    ) -> Post {
        return Post(id: id ?? self.id,
                    title: title ?? self.title,
                    author: author ?? self.author,
                    url: url ?? self.url,
                    subredditNamePrefixed: subredditNamePrefixed ?? self.subredditNamePrefixed
        )
    }
}
