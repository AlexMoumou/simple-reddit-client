//
//  Endpoint.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 24/7/22.
//

import Foundation

protocol Endpoint {
    var url: URL { get }
}

/// BaseUrl of Rick and Morty API Endpoint
private let baseURL = URL(string: "https://www.reddit.com")

private let baseURL_OAUTH = URL(string: "https://oauth.reddit.com")

private let clientID = "wpepFDfBaBStgSalONwunQ"

private let redirectURI = "simpleclient://test"

private let scopes = ["identity", "edit", "flair", "history", "modconfig", "modflair", "modlog", "modposts", "modwiki", "mysubreddits", "privatemessages", "read", "report", "save", "submit", "subscribe", "vote", "wikiedit", "wikiread"]

/// API Endpoints
enum RedditApiEndpoint: Endpoint {
    
    case subredditPosts(String, String, String)
    case homePosts(String, String)
    case findSubreddits(String, String)
    case login

    var url: URL {
        switch self {
            case .subredditPosts(let subName, let sort, let after): return URL(string: "\(subName)/\(sort).json?after=\(after)", relativeTo: baseURL)!
            case .homePosts(let sort, let after): return URL(string: "\(sort).json?after=\(after)", relativeTo: baseURL)!
            case .findSubreddits(let query, let after): return URL(string: "subreddits/search.json?q=\(query)&after=\(after)", relativeTo: baseURL)!
            case .login: return URL(string: "/api/v1/authorize?client_id=\(clientID)&response_type=token&state=unique&redirect_uri=\(redirectURI)&scope=\(scopes.joined(separator: ","))", relativeTo: baseURL)!
        }
    }
}
