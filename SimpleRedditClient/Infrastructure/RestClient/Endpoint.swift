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
    
    case best(String)
    case top(String)
    case rising(String)
    case controversial(String)
    case findSubreddits(String)
    case login

    var url: URL {
        switch self {
            case .best(let after): return URL(string: "best.json?after=\(after)", relativeTo: baseURL)!
            case .top(let after): return URL(string: "top.json?after=\(after)", relativeTo: baseURL)!
            case .rising(let after): return URL(string: "rising.json?after=\(after)", relativeTo: baseURL)!
            case .controversial(let after): return URL(string: "controversial.json?after=\(after)", relativeTo: baseURL)!
            case .findSubreddits(let query): return URL(string: "subreddits/search.json?q=\(query)", relativeTo: baseURL)!
            case .login: return URL(string: "/api/v1/authorize?client_id=\(clientID)&response_type=token&state=unique&redirect_uri=\(redirectURI)&scope=\(scopes.joined(separator: ","))", relativeTo: baseURL)!
        }
    }
}
